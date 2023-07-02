//
//  ToDoListTableViewCellVM.swift
//  ToDoList
//
//  Created by Murad Farhat on 17/06/2023.
//

import UIKit

class ToDoListCellViewModel {
    
    private(set) var taskTitle: String
    private(set) var taskCreatedTime: Date
    private(set) var taskIsDone: Bool
 
    init(taskTitle: String, taskCreatedTime: Date, isDone: Bool) {
        self.taskTitle = taskTitle
        self.taskCreatedTime = taskCreatedTime
        self.taskIsDone = isDone
    }
}
