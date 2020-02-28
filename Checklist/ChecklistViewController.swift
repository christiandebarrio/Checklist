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
  
  required init?(coder aDecoder: NSCoder) {
    
    todoList = TodoList()
    
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    
    if let label =  cell.viewWithTag(1000) as? UILabel {
      let item = todoList.todos[indexPath.row]
      label.text = item.text
    }
    configureCheckmark(for: cell, at: indexPath)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      configureCheckmark(for: cell, at: indexPath)
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
    
    let item = todoList.todos[indexPath.row]
    item.checked = !item.checked
    
    if item.checked {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
  }
}

