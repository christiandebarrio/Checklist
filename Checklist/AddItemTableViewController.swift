//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by Christian de Barrio Arribas on 29/02/2020.
//  Copyright © 2020 Cabify. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
  
  @IBAction func cancel(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func done(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
  }
  
  @IBOutlet weak var textField: UITextField!
}
