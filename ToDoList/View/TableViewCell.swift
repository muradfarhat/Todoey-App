//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Murad Farhat on 14/06/2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var isDoneTask: UISwitch!
    @IBOutlet private weak var toDoItemCreatedDate: UILabel!
    @IBOutlet private weak var toDoItemName: UILabel!
    private var editButtonTapHandler: (() -> Void)?
    private var deleteButtonTapHandler: (() -> Void)?
    private var isDoneButtonTapHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setItemData(task: ToDoListCellViewModel) {
        self.toDoItemName.text = task.taskTitle
        self.toDoItemCreatedDate.text = task.taskCreatedTime.description
        self.isDoneTask.isOn = task.taskIsDone
        self.editButtonTapHandler = task.editButtonHandler
        self.deleteButtonTapHandler = task.deleteButtonHandler
        self.isDoneButtonTapHandler = task.isDoneSwitchHandler
    }
    
    @IBAction func isDoneButton(_ sender: Any) {
        self.isDoneButtonTapHandler?()
    }
    
    @IBAction func editButton(_ sender: Any) {
        self.editButtonTapHandler?()
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        self.deleteButtonTapHandler?()
    }
    
}
