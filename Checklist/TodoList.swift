//
//  TodoList.swift
//  Checklist
//
//  Created by Christian de Barrio Arribas on 28/02/2020.
//  Copyright © 2020 Cabify. All rights reserved.
//

import Foundation

class TodoList {
  var todos: [ChecklistItem] = []

  init() {
    let row0Item = ChecklistItem()
    let row1Item = ChecklistItem()
    let row2Item = ChecklistItem()
    let row3Item = ChecklistItem()
    let row4Item = ChecklistItem()
    
    row0Item.text = "Take a jog"
    row1Item.text = "Watch a movie"
    row2Item.text = "Code an app"
    row3Item.text = "Walk the dog"
    row4Item.text = "Study design patterns"
    
    todos.append(contentsOf: [row0Item, row1Item, row2Item, row3Item, row4Item])
  }
}