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
    
    func createToDoItem(itemName: String) -> ToDoListItem {
        let newItem = ToDoListItem(context: context)
        newItem.name = itemName
        newItem.createdAt = Date()
        newItem.isDone = false
        saveContext()
        return newItem
    }
    
    func deleteToDoItem(item: ToDoListItem) {
        context.delete(item)
        saveContext()
    }
    
    func updateToDoItem(item: ToDoListItem, newName: String) -> ToDoListItem {
        item.name = newName
        saveContext()
        return item
    }
    
    func markAsDone(item: ToDoListItem) -> ToDoListItem{
        item.isDone = item.isDone == true ? false as NSNumber : true as NSNumber
        saveContext()
        return item
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
