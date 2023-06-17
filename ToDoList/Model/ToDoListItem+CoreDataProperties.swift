//
//  ToDoListItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Murad Farhat on 14/06/2023.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var isDone: NSNumber?

}

extension ToDoListItem : Identifiable {

}
