//
//  PasswordCriteriaView.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 20/05/23.
//

import UIKit

class PasswordCriteriaView: UIView{
    override  init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 200, height: 40)
    }
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemOrange
    }
}

