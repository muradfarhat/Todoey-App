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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setItemData(task: ToDoListCellViewModel) {
        self.toDoItemName.text = task.taskTitle
        self.toDoItemCreatedDate.text = task.taskCreatedTime.description
        self.isDoneTask.isOn = task.taskIsDone
    }
    
}
