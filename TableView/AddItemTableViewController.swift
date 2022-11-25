//
//  AddItemTableViewController.swift
//  TableView
//
//  Created by Eyob Arega on 25/11/2022.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    
    @IBOutlet weak var newItemTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newItemTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
      return nil
    }
    
    @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
    }

    @IBAction func done() {
        print("New item: \(newItemTextField.text!)")
        
      navigationController?.popViewController(animated: true)
    }

}
