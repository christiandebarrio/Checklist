//
//  TodoList.swift
//  Checklist
//
//  Created by Christian de Barrio Arribas on 28/02/2020.
//  Copyright © 2020 Cabify. All rights reserved.
//

import Foundation

class TodoList {
  
  enum Priority: Int, CaseIterable {
    case high, medium, low, no
  }
  
  private var highPriorityTodos: [ChecklistItem] = []
  private var mediumPriorityTodos: [ChecklistItem] = []
  private var lowPriorityTodos: [ChecklistItem] = []
  private var noPriorityTodos: [ChecklistItem] = []
  
  
  init() {
    let row0Item = ChecklistItem()
    let row1Item = ChecklistItem()
    let row2Item = ChecklistItem()
    let row3Item = ChecklistItem()
    let row4Item = ChecklistItem()
    let row5Item = ChecklistItem()
    let row6Item = ChecklistItem()
    let row7Item = ChecklistItem()
    let row8Item = ChecklistItem()
    let row9Item = ChecklistItem()
    
    row0Item.text = "Take a jog"
    row1Item.text = "Watch a movie"
    row2Item.text = "Code an app"
    row3Item.text = "Walk the dog"
    row4Item.text = "Study design patterns"
    row5Item.text = "Do exercise"
    row6Item.text = "Go shopping"
    row7Item.text = "Watch a serie"
    row8Item.text = "Buy things"
    row9Item.text = "Got to work"
    
    let items = [row0Item, row1Item, row2Item, row3Item, row4Item, row5Item, row6Item, row7Item, row8Item, row9Item]
    
    for item in items {
      let randomIndex = Int.random(in: 0...Priority.allCases.count - 1)
      let priority = Priority.allCases[randomIndex]
      self.addTodo(item, for: priority)
    }
  }
  
  func addTodo(_ item: ChecklistItem, for priority: Priority) {
    switch priority {
    case .high:
      highPriorityTodos.append(item)
    case .medium:
      mediumPriorityTodos.append(item)
    case .low:
      lowPriorityTodos.append(item)
    case .no:
      noPriorityTodos.append(item)
    }
  }
  
  func todoList(for priority: Priority) -> [ChecklistItem] {
    switch priority {
    case .high:
      return highPriorityTodos
    case .medium:
      return mediumPriorityTodos
    case .low:
      return lowPriorityTodos
    case .no:
      return noPriorityTodos
    }
  }
  
  func newTodo() -> ChecklistItem {
    let item = ChecklistItem()
    item.text = getRandomTitle()
    mediumPriorityTodos.append(item)
    
    return item
  }
  
  func move(item: ChecklistItem, to index: Int) {
    //    guard let currentIndex = todos.firstIndex(of: item) else { return }
    //    todos.remove(at: currentIndex)
    //    todos.insert(item, at: index)
  }
  
  func remove(_ item: ChecklistItem, from priority: Priority, at index: Int){
    switch priority {
    case .high:
      highPriorityTodos.remove(at: index)
    case .medium:
      mediumPriorityTodos.remove(at: index)
    case .low:
      lowPriorityTodos.remove(at: index)
    case .no:
      noPriorityTodos.remove(at: index)
    }
  }
  
  private func getRandomTitle() -> String {
    let titles = [
      "New todo item",
      "Generic todo",
      "Fill me out",
      "I nedd something to do",
      "Much todo about nothing"
    ]
    let randomNumber = Int.random(in: 0 ... titles.count - 1)
    
    return titles[randomNumber]
  }
}
