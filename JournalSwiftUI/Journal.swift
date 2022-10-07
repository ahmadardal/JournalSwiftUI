//
//  Journal.swift
//  JournalSwiftUI
//
//  Created by Ahmad Ardal on 2022-10-04.
//

import Foundation

class Journal: ObservableObject {
    
    @Published private var entries = [JournalEntry]()
    
    func addEntry(entry: JournalEntry) {
        if entry.title == "" || entry.description == "" {
            return
        }
        
        entries.append(entry)
    }
    
    func removeEntryAt(index: Int) {
        entries.remove(at: index)
    }
    
    func getEntryAt(index: Int) -> JournalEntry? {
        return entries[index]
    }
    
    func getEntryByTitle(title: String) -> JournalEntry? {
        for entry in entries {
            if entry.title == title {
                return entry
            }
        }

        return nil
    }
    
    func getAllEntries() -> [JournalEntry] {
        return entries
    }
    
}
