//
//  Persistance.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/12/22.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ItemModel")
        
        container.loadPersistentStores{(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
}
