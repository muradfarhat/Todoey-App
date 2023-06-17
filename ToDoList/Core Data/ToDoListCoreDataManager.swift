//
//  ToDoListCoreDataManager.swift
//  ToDoList
//
//  Created by Murad Farhat on 16/06/2023.
//

import Foundation
import CoreData

class ToDoListCoreDataManager {
    
    static let shared = ToDoListCoreDataManager() // Singleton instance
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
