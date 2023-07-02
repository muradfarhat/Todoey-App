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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // trailing swipe actions method
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteItem = UIContextualAction(style: .destructive, title: "") { (contextualAction, view, boolValue) in
            self.ToDoListCoreDataVM.deleteToDoItem(item: self.models[indexPath.row])
            self.models.remove(at: indexPath.row)
            self.toDoItemsTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.right)
        }
        deleteItem.backgroundColor = UIColor.red
        deleteItem.image = UIImage(systemName: "trash")
        
        let editItem = UIContextualAction(style: .normal, title: "") { (contextualAction, view, boolValue) in
            self.toDoItemEditAlert(task: self.models[indexPath.row], index: indexPath)
        }
        editItem.backgroundColor = UIColor.blue
        editItem.image = UIImage(systemName: "square.and.pencil")
        
        let trailingSwipeActions = UISwipeActionsConfiguration(actions: [deleteItem, editItem])
        return trailingSwipeActions
    }
    
    // leading swipe actions method
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let markAsDone = UIContextualAction(style: .normal, title: "") { (contextualAction, view, boolValue) in
            self.models[indexPath.row] = self.ToDoListCoreDataVM.markAsDone(item: self.models[indexPath.row])
            self.toDoItemsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        markAsDone.backgroundColor = UIColor.brown
        markAsDone.image = UIImage(systemName: "checkmark.circle")
        
        let leadingSwipeActions = UISwipeActionsConfiguration(actions: [markAsDone])
        return leadingSwipeActions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoItemsTableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        
        let ToDoListCellViewModel = ToDoListCellViewModel(taskTitle: models[indexPath.row].name!, taskCreatedTime: models[indexPath.row].createdAt!, isDone: models[indexPath.row].isDone as! Bool)
        
        cell?.setItemData(task: ToDoListCellViewModel)
        
        return cell ?? UITableViewCell()
    }
}

