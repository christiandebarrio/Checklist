//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by Christian de Barrio Arribas on 29/02/2020.
//  Copyright © 2020 Cabify. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
  func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
  func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem)
}

class AddItemTableViewController: UITableViewController {
  
  weak var delegate: AddItemViewControllerDelegate?
  
  @IBOutlet weak var textfield: UITextField!
  @IBOutlet weak var addBarButton: UIBarButtonItem!
  @IBOutlet weak var cancelBarButton: UIBarButtonItem!
  
  @IBAction func cancel(_ sender: Any) {
    navigationController?.popViewController(animated: true)
    delegate?.addItemViewControllerDidCancel(self)
  }
  
  @IBAction func done(_ sender: Any) {
    navigationController?.popViewController(animated: true)
    let item = ChecklistItem()
    if let textFieldText = textfield.text {
      item.text = textFieldText
    }
    delegate?.addItemViewController(self, didFinishAdding: item)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    textfield.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    textfield.becomeFirstResponder()
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
}

extension AddItemTableViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textfield.resignFirstResponder()
    return false
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let oldText = textfield.text,
      let stringRange = Range(range, in: oldText) else {
        return false
    }
    
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    if newText.isEmpty {
      addBarButton.isEnabled = false
    } else {
      addBarButton.isEnabled = true
    }
    return true
  }
}