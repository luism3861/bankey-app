//
//  PasswordCriteriaView.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 20/05/23.
//

import UIKit

class PasswordCriteriaView: UIView{
     let stackView = UIStackView()
     let imageView = UIImageView()
    let label = UILabel()
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    
    var isCriterialMet: Bool = false{
        didSet{
            if isCriterialMet{
                imageView.image = checkmarkImage
            }else{
                imageView.image = xmarkImage
            }
        }
    }
    
    func reset(){
        isCriterialMet = false
        imageView.image = circleImage
    }
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    init(_ text: String){
        super.init(frame: .zero)
        label.text = text
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 200, height: 40)
    }
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel,
                                                                       renderingMode: .alwaysOriginal)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        
    }
    
    func layout(){
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        imageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
}

