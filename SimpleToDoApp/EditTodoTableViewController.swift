//
//  EditTodoTableViewController.swift
//  SimpleToDoApp
//
//  Created by 桑染 on 2020-05-06.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

protocol EditDelegate {
    func edit(todo: String, section: Int, row: Int)
}

class EditTodoTableViewController: UITableViewController {

    var editDelegate: EditDelegate?
    var indexPathSection = 0
    var indexPathRow = 0
    
    let editCell: AddTodoTableViewCell = {
            let cell = AddTodoTableViewCell()
            return cell
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationItem.title = "Edit Todo Item"
            navigationItem.largeTitleDisplayMode = .never
            tableView.rowHeight = 70
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTodo))
        }
        
        @objc func saveTodo(_ sender: UIBarButtonItem) {
            self.editDelegate?.edit(todo: editCell.todoTextField.text!, section: indexPathSection, row: indexPathRow)
            navigationController?.popViewController(animated: true)
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return 1
            }
            return 0
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return editCell
        }
    }
