//
//  Checklist.swift
//  TableView
//
//  Created by Eyob Arega on 30/11/2022.
//

import Foundation

class Checklist: NSObject, Codable {
    var name = ""
    var icon = ""
    var items = [ChecklistItem]()
    
    var uncheckedItemsCount: Int {
        get {
            return items.reduce(0) {
                cnt,item in cnt + (item.checked ? 0 : 1)
            }
        }
    }
    
    init(name: String, icon: String = "No Icon") {
        self.name = name
        self.icon = icon
    }
    
}
