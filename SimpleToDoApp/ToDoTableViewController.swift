//
//  ToDoTableViewController.swift
//  SimpleToDoApp
//
//  Created by 桑染 on 2020-05-04.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, AddTodoTableViewDelegate, EditDelegate {
    
    let cellId = "cellId"
    
    var isSelected = [[Int](), [Int](), [Int]()]
    
    private var priorityNumbers = ["High Priority", "Medium Priority", "Low Priority"]
    
    private var highPriority = ["Money", "Wifi"]
    private var mediuPriority = ["Car"]
    private var lowPriority = ["House"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Todo Items"
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: cellId)
        let deleteBarButton = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(deleteTodo))
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddTodo))
        navigationItem.rightBarButtonItems = [addBarButton, deleteBarButton]
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsMultipleSelection = true
    }
    
    func add(todo: String) {
        mediuPriority.append(todo)
        tableView.insertRows(at: [IndexPath(row: mediuPriority.count - 1, section: 1)], with: .automatic)
    }
    
    func edit(todo: String, section: Int, row: Int) {
        switch section {
        case 0:
            highPriority[row] = todo
        case 1:
            mediuPriority[row] = todo
        case 2:
            lowPriority[row] = todo
        default:
            fatalError()
        }
        tableView.reloadData()
    }
    
    @objc func deleteTodo(_ sender: UIBarButtonItem) {
        if !isSelected[0].isEmpty {
            highPriority.remove(elementsAtIndices: isSelected[0])
            isSelected[0].removeAll()
        }
        if !isSelected[1].isEmpty {
            mediuPriority.remove(elementsAtIndices: isSelected[1])
            isSelected[1].removeAll()
        }
        if !isSelected[2].isEmpty {
            lowPriority.remove(elementsAtIndices: isSelected[2])
            isSelected[2].removeAll()
        }
        tableView.reloadData()
    }
    
    @objc func goToAddTodo(_ sender: UIBarButtonItem) {
        let addVC = AddTodoTableViewController()
        addVC.delegate = self
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return priorityNumbers.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return priorityNumbers[0]
        case 1:
            return priorityNumbers[1]
        case 2:
            return priorityNumbers[2]
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return highPriority.count
        case 1:
            return mediuPriority.count
        case 2:
            return lowPriority.count
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ToDoTableViewCell
        cell.accessoryType = .detailDisclosureButton
        switch indexPath.section {
        case 0:
            cell.todoLabel.text = highPriority[indexPath.row]
        case 1:
            cell.todoLabel.text = mediuPriority[indexPath.row]
        case 2:
            cell.todoLabel.text = lowPriority[indexPath.row]
        default:
            fatalError()
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
            case 0:
                highPriority.remove(at: indexPath.row)
            case 1:
                mediuPriority.remove(at: indexPath.row)
            case 2:
                lowPriority.remove(at: indexPath.row)
            default:
                fatalError()
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todoItem: String
        let editVC = EditTodoTableViewController()
        
        switch sourceIndexPath.section {
        case 0:
            todoItem = highPriority.remove(at: sourceIndexPath.row)
        case 1:
            todoItem = mediuPriority.remove(at: sourceIndexPath.row)
        case 2:
            todoItem = lowPriority.remove(at: sourceIndexPath.row)
        default:
            fatalError()
        }
        switch destinationIndexPath.section {
        case 0:
            highPriority.insert(todoItem, at: destinationIndexPath.row)
            editVC.editCell.todoTextField.text = highPriority[destinationIndexPath.row]
        case 1:
            mediuPriority.insert(todoItem, at: destinationIndexPath.row)
            editVC.editCell.todoTextField.text = mediuPriority[destinationIndexPath.row]
        case 2:
            lowPriority.insert(todoItem, at: destinationIndexPath.row)
            editVC.editCell.todoTextField.text = lowPriority[destinationIndexPath.row]
        default:
            fatalError()
        }
        
        let indexPathSection = destinationIndexPath.section
        let indexRow = destinationIndexPath.row
        editVC.indexPathSection = indexPathSection
        editVC.indexPathRow = indexRow
        editVC.editDelegate = self
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            if indexPath.section == 0 {
                isSelected[0].append(indexPath.row)
            }
            if indexPath.section == 1 {
                isSelected[1].append(indexPath.row)
            }
            if indexPath.section == 2 {
                isSelected[2].append(indexPath.row)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .detailDisclosureButton
            if indexPath.section == 0 {
                isSelected[0].remove(at: indexPath.row)
            }
            if indexPath.section == 1 {
                isSelected[1].remove(at: indexPath.row)
            }
            if indexPath.section == 2 {
                isSelected[2].remove(at: indexPath.row)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let editVC = EditTodoTableViewController()
        switch indexPath.section {
        case 0:
            editVC.editCell.todoTextField.text = highPriority[indexPath.row]
        case 1:
            editVC.editCell.todoTextField.text = mediuPriority[indexPath.row]
        case 2:
            editVC.editCell.todoTextField.text = lowPriority[indexPath.row]
        default:
            fatalError()
        }
        let indexPathSection = indexPath.section
        let indexRow = indexPath.row
        editVC.indexPathSection = indexPathSection
        editVC.indexPathRow = indexRow
        editVC.editDelegate = self
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}

extension Array {
    mutating func remove(elementsAtIndices indicesToRemove: [Int]) {
        for indexToRemove in indicesToRemove.sorted(by: >) {
            remove(at: indexToRemove)
        }
    }
}
