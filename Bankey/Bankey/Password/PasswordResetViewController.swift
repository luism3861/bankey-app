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
    let statusView = PasswordStatusView()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Password Reset"

        style()
        layout()
        prepMainViewDisable()
    }
    
  
}


extension PasswordResetViewController{
    func style(){
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
      
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
//        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
        ])
    }
}


