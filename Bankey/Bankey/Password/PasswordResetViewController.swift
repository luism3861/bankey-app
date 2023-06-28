//
//  PasswordResetViewController.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 12/05/23.
//

import UIKit



class PasswordResetViewController: UIViewController {
    
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let stackView = UIStackView()
    let statusView = PasswordStatusView()
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Password Reset"
        dissmissKeyboard()
        style()
        layout()
    }
    
  
}


extension PasswordResetViewController{
    
  
    
    func style(){
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.delegate = self
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset Password", for: [])
//         resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)

      
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 5
        statusView.clipsToBounds = true
    }
    
    func layout(){
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)

        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
        ])
    }
}


extension PasswordResetViewController: PasswordTextFieldDelegate{
    func editingChanged(_ sender: PasswordTextField){
        if sender == newPasswordTextField{
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
}
