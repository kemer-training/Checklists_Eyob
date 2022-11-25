//
//  ViewController.swift
//  TableView
//
//  Created by Eyob Arega on 23/11/2022.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var checklistItems = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeChecklists()
    }
    
    func initializeChecklists() {
        checklistItems.append(ChecklistItem(text: "Walk the dog"))
        
        checklistItems.append(ChecklistItem(text: "Brush my teeth"))
        
        checklistItems.append(ChecklistItem(text: "Learn iOS development", checked: true))

        checklistItems.append(ChecklistItem(text: "Soccer practice"))
        
        checklistItems.append(ChecklistItem(text: "Eat ice cream"))
    }
    
    func configureCheckMark(_ cell: UITableViewCell, _ checklistItem: ChecklistItem) {
        cell.accessoryType = checklistItem.checked ? .checkmark : .none
    }
    
    func configureText(_ cell: UITableViewCell, _ checklistItem: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = checklistItem.text
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklistItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let checklistItem = checklistItems[indexPath.row]
        
        configureText(cell, checklistItem)
        configureCheckMark(cell, checklistItem)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let checklistItem = checklistItems[indexPath.row]
            checklistItem.checked.toggle()
            configureCheckMark(cell, checklistItem)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ) {
      checklistItems.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    
    @IBAction func addItem() {
        let numOfChecklists = checklistItems.count
        
        let item = ChecklistItem(text: "New stuff")
        checklistItems.append(item)
        
        let indexPath = IndexPath(row: numOfChecklists, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

