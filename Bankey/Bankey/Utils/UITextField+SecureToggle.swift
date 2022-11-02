//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 01/11/22.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField{
    func enablePasswordToggle(){
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.tintColor = appColor
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(){
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
