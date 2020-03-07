//
//  ViewController.swift
//  Checklist
//
//  Created by Christian de Barrio Arribas on 28/02/2020.
//  Copyright © 2020 Cabify. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
  
  var todoList: TodoList

  private func priorityForSectionIndex(_ index: Int) -> TodoList.Priority? {
    return TodoList.Priority(rawValue: index)
  }
  
  @IBAction func addItem(_ sender: Any) {
    let newRowIndex = todoList.todoList(for: .medium).count
    _ = todoList.newTodo()
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
  }
  
  
  @IBAction func deleteItems(_ sender: Any) {
    if let selectedRows = tableView.indexPathsForSelectedRows {
      for indexPath in selectedRows {
        if let priority = priorityForSectionIndex(indexPath.section){
          let todos = todoList.todoList(for: priority)
          
          let rowToDelete = indexPath.row > todos.count - 1 ? todos.count - 1 : indexPath.row
          let item = todos[rowToDelete]
          todoList.remove(item, from: priority, at: rowToDelete)
        }
      }
      tableView.beginUpdates()
      tableView.deleteRows(at: selectedRows, with: .automatic)
      tableView.endUpdates()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    todoList = TodoList()
    super.init(coder: aDecoder)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.leftBarButtonItem = editButtonItem
    tableView.allowsMultipleSelectionDuringEditing = true
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: true)
    tableView.setEditing(tableView.isEditing, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let priority = priorityForSectionIndex(section){
      return todoList.todoList(for: priority).count
    }
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    if let priority = priorityForSectionIndex(indexPath.section){
      let items = todoList.todoList(for: priority)
      let item = items[indexPath.row]
      configureText(for: cell, with: item)
      configureCheckmark(for: cell, with: item)
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView.isEditing { return }
    if let cell = tableView.cellForRow(at: indexPath) {
      if let priority = priorityForSectionIndex(indexPath.section){
        let items = todoList.todoList(for: priority)
        let item = items[indexPath.row]
        item.toggleChecked()
        configureCheckmark(for: cell, with: item)
        tableView.deselectRow(at: indexPath, animated: true)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if let priority = priorityForSectionIndex(indexPath.section){
      let item = todoList.todoList(for: priority)[indexPath.row]
      todoList.remove(item, from: priority, at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    if let sourcePriority = priorityForSectionIndex(sourceIndexPath.section),
      let destinationPriority = priorityForSectionIndex(destinationIndexPath.section) {
      let item = todoList.todoList(for: sourcePriority)[sourceIndexPath.row]
      todoList.move(item: item, from: sourcePriority, at: sourceIndexPath.row, to: destinationPriority, at: destinationIndexPath.row)
    }
    tableView.reloadData()
  }
  
  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    if let checkmarkCell = cell as? ChecklistTableViewCell {
      checkmarkCell.todoTextLabel.text = item.text
    }
  }
  
  func configureCheckmark(for cell: UITableViewCell, with item:ChecklistItem ) {
    guard let checkmarkCell = cell as? ChecklistTableViewCell else { return }
    
    if item.checked {
      checkmarkCell.checkmarkLabel.text = "√"
    } else {
      checkmarkCell.checkmarkLabel.text  = ""
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItemSegue" {
      if let itemDetailViewController = segue.destination as? ItemDetailViewController {
        itemDetailViewController.delegate = self
        itemDetailViewController.todoList = todoList
      }
    } else if segue.identifier == "EditItemSegue" {
      if let itemDetailViewController = segue.destination as? ItemDetailViewController {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell), let priority = priorityForSectionIndex(indexPath.section) {
          let item = todoList.todoList(for: priority)[indexPath.row]
          itemDetailViewController.itemToEdit = item
          itemDetailViewController.delegate = self
        }
      }
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return TodoList.Priority.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let priority = priorityForSectionIndex(section){
      switch priority {
      case .high:
        return "High Priority Todos"
      case .medium:
        return "Medium Priority Todos"
      case .low:
        return "Low Priority Todos"
      case .no:
        return "Someday Todos"
      }
    }
    return nil
  }
  
  override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
  }
  
}

extension ChecklistViewController: ItemDetailViewControllerDelegate {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
    navigationController?.popViewController(animated: true)
    let rowIndex = todoList.todoList(for: .medium).count - 1
    let indexPath = IndexPath(row: rowIndex, section: TodoList.Priority.medium.rawValue)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }
  
  func itemDetailViewController(_ controler: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
    
    for priority in TodoList.Priority.allCases {
      let currentList = todoList.todoList(for: priority)
      if let index = currentList.firstIndex(of: item) {
        let indexPath = IndexPath(row: index, section: priority.rawValue)
        if let cell = tableView.cellForRow(at: indexPath) {
          configureText(for: cell, with: item)
        }
      }
    }
    navigationController?.popViewController(animated: true)
  }
}
