//
//  DataModel.swift
//  TableView
//
//  Created by Eyob Arega on 30/11/2022.
//

import Foundation

class DataModel {
    var checklists = [Checklist]()
    
    init() {
        loadChecklists()
        sortChecklists()
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(checklists)
            try data.write(
                to: dataFilePath(),
                options: Data.WritingOptions.atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadChecklists() {
        if let data = try? Data(contentsOf: dataFilePath()) {
            let decoder = PropertyListDecoder()
            do {
                checklists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func sortChecklists() {
        checklists.sort { list1, list2 in
            return list1.name.localizedStandardCompare(list2.name) == .orderedAscending
        }
    }
}
