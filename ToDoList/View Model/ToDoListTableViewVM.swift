//
//  CoreDataMethods.swift
//  ToDoList
//
//  Created by Murad Farhat on 15/06/2023.
//

import UIKit

class ToDoListTableViewVM {
    
    private let context = ToDoListCoreDataManager.shared.persistentContainer.viewContext

    func getAllToDoListItems() -> [ToDoListItem] {
        var models: [ToDoListItem] = []
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            return models
        } catch {
            print(error.localizedDescription)
        }
        return models
    }
    
    func createToDoItem(itemName: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = itemName
        newItem.createdAt = Date()
        newItem.isDone = false
        saveContext()
    }
    
    func deleteToDoItem(item: ToDoListItem) {
        context.delete(item)
        saveContext()
    }
    
    func updateToDoItem(item: ToDoListItem, newName: String) {
        item.name = newName
        saveContext()
    }
    
    func markAsDone(item: ToDoListItem) {
        item.isDone = item.isDone == true ? false as NSNumber : true as NSNumber
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
