//
//  PasswordResetViewController.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 12/05/23.
//

import UIKit

class PasswordResetViewController: UIViewController {
    
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        style()
        layout()
    }
}


extension PasswordResetViewController{
    func style(){
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
    }
    
    func layout(){
        stackView.addArrangedSubview(newPasswordTextField)
        view.addSubview(stackView)
        
    
        
        NSLayoutConstraint.activate([
            newPasswordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: newPasswordTextField.trailingAnchor, multiplier: 1),
            newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
        ])
    }
}


