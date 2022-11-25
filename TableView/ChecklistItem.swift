//
//  ChecklistItem.swift
//  TableView
//
//  Created by Eyob Arega on 25/11/2022.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    init(text: String = "", checked: Bool = false) {
        self.text = text
        self.checked = checked
    }
}
