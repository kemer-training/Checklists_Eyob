//
//  AllListsViewController.swift
//  TableView
//
//  Created by Eyob Arega on 30/11/2022.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    let cellIdentifier = "ChecklistCell"
    
    var dataModel: DataModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataModel.dataFilePath())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        
        let index = UserDefaults.standard.integer(forKey: "ChecklistIndex")
        if index >= 0 && index < dataModel.checklists.count {
            let checklist = dataModel.checklists[index]
            
            performSegue(withIdentifier: "showChecklist", sender: checklist)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.checklists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let tmp = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier) {
            cell = tmp
        } else {
            cell = UITableViewCell(
                style: .subtitle,
                reuseIdentifier: cellIdentifier)
        }
        
        
        let checklist = dataModel.checklists[indexPath.row]
        cell.textLabel?.text = checklist.name
        
        
        if (checklist.items.count == 0) {
            cell.detailTextLabel?.text = "(No items)"
        } else {
            let unchecked = checklist.uncheckedItemsCount
            
            cell.detailTextLabel?.text = unchecked == 0 ? "All done": "\(unchecked) Remaining"
        }
        
        cell.accessoryType = .detailDisclosureButton
        cell.imageView?.image = UIImage(named: checklist.icon)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UserDefaults.standard.set(indexPath.row, forKey: "ChecklistIndex")
        
        let checklist = dataModel.checklists[indexPath.row]
        
        performSegue(withIdentifier: "showChecklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        
        vc.checklistToEdit = dataModel.checklists[indexPath.row]
        vc.delegate = self
        
        navigationController?.pushViewController(
            vc,
            animated: true)
    }
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        dataModel.checklists.append(checklist)
        dataModel.sortChecklists()
        tableView.reloadData()
        navigationController?.popToViewController(self, animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        dataModel.sortChecklists()
        tableView.reloadData()
        navigationController?.popToViewController(self, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChecklist" {
            let vc = segue.destination as! ChecklistViewController
            vc.checklist = sender as? Checklist
        } else if segue.identifier == "addChecklist" {
            let vc = segue.destination as! ListDetailViewController
            vc.delegate = self
        }
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        if viewController === self {
            UserDefaults.standard.set(-1, forKey: "ChecklistIndex")
        }
    }
}
