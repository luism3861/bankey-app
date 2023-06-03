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
    let criteriaView = PasswordCriteriaView("uppercase letter (A-Z) ")
    
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
        
        criteriaView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
//        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(criteriaView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
        ])
    }
}


