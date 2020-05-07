//
//  AddTodoTableViewController.swift
//  SimpleToDoApp
//
//  Created by 桑染 on 2020-05-04.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

protocol AddTodoTableViewDelegate: class {
    func add(todo: String)
}

class AddTodoTableViewController: UITableViewController {

    weak var delegate: AddTodoTableViewDelegate?
    
    let addCell: AddTodoTableViewCell = {
        let cell = AddTodoTableViewCell()
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Todo Item"
        navigationItem.largeTitleDisplayMode = .never
        tableView.rowHeight = 70
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTodo))
    }
    
    @objc func saveTodo(_ sender: UIBarButtonItem) {
        self.delegate?.add(todo: addCell.todoTextField.text!)
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
        return addCell
    }
}
