//
//  ViewController.swift
//  TableView
//
//  Created by Eyob Arega on 23/11/2022.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var checklist: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = checklist.name
    }
    
    func configureCheckMark(_ cell: UITableViewCell, _ checklistItem: ChecklistItem) {
        let checkmark = cell.viewWithTag(1001) as! UILabel
        checkmark.text = checklistItem.checked ?  "✓" : ""
    }
    
    func configureText(_ cell: UITableViewCell, _ checklistItem: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = checklistItem.text
    }
    
    func configureCell(_ cell: UITableViewCell, _ checklistItem: ChecklistItem) {
        configureText(cell, checklistItem)
        configureCheckMark(cell, checklistItem)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let checklistItem = checklist.items[indexPath.row]
        
        configureCell(cell, checklistItem)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let checklistItem = checklist.items[indexPath.row]
        checklistItem.checked.toggle()
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ) {
      checklist.items.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        checklist.items.append(item)
        tableView.reloadData()
        navigationController?.popToViewController(self, animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        tableView.reloadData()
        navigationController?.popToViewController(self, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let vc = segue.destination as! ItemDetailViewController
            vc.delegate = self
        } else if segue.identifier == "editItem" {
            let vc = segue.destination as! ItemDetailViewController
            vc.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                vc.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
}

