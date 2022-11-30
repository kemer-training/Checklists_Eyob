//
//  IconPickerViewController.swift
//  TableView
//
//  Created by Eyob Arega on 30/11/2022.
//

import UIKit

protocol IconPickerViewControllerDelegate: AnyObject {
    func iconPicker(
        _ picker: IconPickerViewController,
        didPick iconName: String)
}

class IconPickerViewController: UITableViewController {
    weak var delegate: IconPickerViewControllerDelegate?
    
    let icons = [
        "No Icon", "Appointments", "Birthdays", "Chores",
        "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"
    ]
    
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
      return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)
        
        let icon = icons[indexPath.row]
        cell.textLabel?.text = icon
        cell.imageView?.image = UIImage(named: icon)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let icon = icons[indexPath.row]
        delegate?.iconPicker(self, didPick: icon)
    }
}
