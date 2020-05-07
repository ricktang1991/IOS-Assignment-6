//
//  AddTodoTableViewCell.swift
//  SimpleToDoApp
//
//  Created by 桑染 on 2020-05-04.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class AddTodoTableViewCell: UITableViewCell {
    
    let todoTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.boldSystemFont(ofSize: 25)
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(todoTextField)
        NSLayoutConstraint.activate([
            todoTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            todoTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            todoTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            todoTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
