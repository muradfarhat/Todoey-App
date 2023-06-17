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
    private(set) var editButtonHandler: (() -> Void)
    private(set) var deleteButtonHandler: (() -> Void)
    private(set) var isDoneSwitchHandler: (() -> Void)
 
    init(taskTitle: String, taskCreatedTime: Date, isDone: Bool, editHandler: @escaping (() -> Void), deleteHandler: @escaping (() -> Void), isDoneHandler: @escaping (() -> Void)) {
        self.taskTitle = taskTitle
        self.taskCreatedTime = taskCreatedTime
        self.taskIsDone = isDone
        self.editButtonHandler = editHandler
        self.deleteButtonHandler = deleteHandler
        self.isDoneSwitchHandler = isDoneHandler
    }
}
