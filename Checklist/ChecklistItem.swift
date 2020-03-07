//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Christian de Barrio Arribas on 28/02/2020.
//  Copyright © 2020 Cabify. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
  
  @objc var text = ""
  var checked = true
  
  func toggleChecked() {
    checked = !checked
  }
}
