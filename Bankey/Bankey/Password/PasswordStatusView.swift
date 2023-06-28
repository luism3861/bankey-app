//
//  PasswordStatusView.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 06/06/23.
//

import UIKit


class PasswordStatusView: UIView{
    let stackView = UIStackView()
    let lengthCriteriaView = PasswordCriteriaView("8-32 characters (no spaces)")
    let upperCaseCriteriaView = PasswordCriteriaView("uppercase letter (A-Z)")
    let lowerCaseCriteriaView = PasswordCriteriaView("lowercase (a-z)")
    let digitCriteriaView = PasswordCriteriaView("digit (0-9)")
    let specialCharacterCriteriaView = PasswordCriteriaView("special character (e.g. !@#$%^)")
    private var shouldResetCriteria: Bool = true
    
    let criteriaLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 200, height: 160)
    }
}


extension PasswordStatusView{
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        
        lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        upperCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        lowerCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        
        criteriaLabel.numberOfLines = 0
        criteriaLabel.lineBreakMode = .byWordWrapping
        criteriaLabel.attributedText = makeCriteriaMessage()
    }
    func layout(){
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(upperCaseCriteriaView)
        stackView.addArrangedSubview(lowerCaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
        
        
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
        ])
    }
}


extension PasswordStatusView{
    private func makeCriteriaMessage() -> NSAttributedString{
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        boldTextAttributes[.foregroundColor] = UIColor.label

        let attrText = NSMutableAttributedString(string: "Use at least", attributes: plainTextAttributes)
        attrText.append(NSMutableAttributedString(string: " 3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSMutableAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))
        return attrText
    }
}


extension PasswordStatusView{
    func updateDisplay(_ text: String){
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)

        
        if shouldResetCriteria{
            lengthAndNoSpaceMet ?
            lengthCriteriaView.isCriterialMet = true : lengthCriteriaView.reset()
            
            uppercaseMet ?
            upperCaseCriteriaView.isCriterialMet = true : upperCaseCriteriaView.reset()
            
            lowercaseMet ?
            lowerCaseCriteriaView.isCriterialMet = true : lowerCaseCriteriaView.reset()
            
            digitMet ?
            digitCriteriaView.isCriterialMet = true : digitCriteriaView.reset()
            
            specialCharacterMet ?
            specialCharacterCriteriaView.isCriterialMet = true : specialCharacterCriteriaView.reset()
            
        }
    }
}
