//
//  ViewController.swift
//  ToDoList
//
//  Created by Murad Farhat on 14/06/2023.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var toDoItemsTableView: UITableView!
    private let ToDoListCoreDataVM = ToDoListTableViewVM()
    private var models: [ToDoListItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "To Do List"
        navBarItems()
        
        toDoItemsTableView.delegate = self
        toDoItemsTableView.dataSource = self
        toDoItemsTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        reloadTableData()
    }
    
    func reloadTableData() {
        self.models = ToDoListCoreDataVM.getAllToDoListItems()
        self.toDoItemsTableView.reloadData()
    }
    
    func navBarItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navBarAddButton))
    }
    
    // Add Item To List
    @objc func navBarAddButton() {
        let addItemDialog = UIAlertController(title: "Add Task", message: "", preferredStyle: .alert)
        
        addItemDialog.addTextField(configurationHandler: { textField in
            textField.placeholder =  "Add your task"
        })
        
        let add = UIAlertAction(title: "Add", style: .default, handler: { action in
            let textFieldContent = addItemDialog.textFields?.first?.text ?? ""
            let newTask = self.ToDoListCoreDataVM.createToDoItem(itemName: textFieldContent)
            self.models.append(newTask)
            self.toDoItemsTableView.reloadData()
        })
        addItemDialog.addAction(add)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        addItemDialog.addAction(cancel)
        
        self.present(addItemDialog, animated: true)
    }
    
    // Edit item in table method
    func toDoItemEditAlert(task: ToDoListItem, index: IndexPath) {
        let addItemDialog = UIAlertController(title: "Edit Task", message: task.name, preferredStyle: .alert)
        
        addItemDialog.addTextField(configurationHandler: { textField in
            textField.placeholder =  "Edit your task"
        })
        
        let add = UIAlertAction(title: "Edit", style: .default, handler: { action in
            let textFieldContent = addItemDialog.textFields?.first?.text ?? ""
            self.models[index.row] = self.ToDoListCoreDataVM.updateToDoItem(item: task, newName: textFieldContent)
            self.toDoItemsTableView.reloadRows(at: [index], with: .automatic)
        })
        addItemDialog.addAction(add)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        addItemDialog.addAction(cancel)
        
        self.present(addItemDialog, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoItemsTableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        
        let editButtonHandler = {
            self.toDoItemEditAlert(task: self.models[indexPath.row], index: indexPath)
        }
        
        let deleteButtonHandler = {
            self.ToDoListCoreDataVM.deleteToDoItem(item: self.models[indexPath.row])
            self.models.remove(at: indexPath.row)
            self.toDoItemsTableView.reloadData()
        }
        
        let isDoneButtonHandler = {
            self.models[indexPath.row] = self.ToDoListCoreDataVM.markAsDone(item: self.models[indexPath.row])
            self.toDoItemsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        let ToDoListCellViewModel = ToDoListCellViewModel(taskTitle: models[indexPath.row].name!, taskCreatedTime: models[indexPath.row].createdAt!, isDone: models[indexPath.row].isDone as! Bool, editHandler: editButtonHandler, deleteHandler: deleteButtonHandler, isDoneHandler: isDoneButtonHandler)
        
        cell?.setItemData(task: ToDoListCellViewModel)
        
        return cell ?? UITableViewCell()
    }
}

