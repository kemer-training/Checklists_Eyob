//
//  ListDetailViewController.swift
//  TableView
//
//  Created by Eyob Arega on 30/11/2022.
//

import UIKit

protocol ListDetailViewControllerDelegate: AnyObject {
    func listDetailViewControllerDidCancel(
        _ controller: ListDetailViewController)
    
    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishAdding checklist: Checklist
    )
    
    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishEditing checklist: Checklist
    )
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    var icon = "No Icon"
    
    weak var delegate: ListDetailViewControllerDelegate?
    
    var checklistToEdit: Checklist?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklistToEdit.name
            icon = checklistToEdit.icon
            doneBarButton.isEnabled = true
        }
        
        loadIconImage()
    }
    
    func loadIconImage() {
        iconImage.image = UIImage(named: icon)
    }
    
    override func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return indexPath.section == 1 ? indexPath : nil
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(
            in: stringRange,
            with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
        icon = iconName
        loadIconImage()
        navigationController?.popToViewController(self, animated: true)
    }
    
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            checklist.icon = icon
            delegate?.listDetailViewController(
                self,
                didFinishEditing: checklist)
        } else {
            let checklist = Checklist(name: textField.text!, icon: icon)
            delegate?.listDetailViewController(
                self,
                didFinishAdding: checklist)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickIcon" {
            let vc = segue.destination as! IconPickerViewController
            vc.delegate = self
        }
    }
}

