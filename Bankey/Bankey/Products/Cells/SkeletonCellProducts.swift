//
//  SkeletonCellProducts.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 16/03/23.
//

import UIKit

//protocol SkeletonLoadable can access all the properties
extension SkeletonCellProducts: SkeletonLoadable {}

class SkeletonCellProducts: UITableViewCell {
    
    let productName = UILabel()
    
    
    
    // Gradients
    let productLayer = CAGradientLayer()
    
    static let reuseID = "SkeletonCellProducts"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupLayers()
        setupAnimation()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        productLayer.frame = productName.bounds
        productLayer.cornerRadius = productName.bounds.height/2
    }
}

extension SkeletonCellProducts {
    
    private func setup() {
        
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.font = UIFont.preferredFont(forTextStyle: .body)
        productName.adjustsFontSizeToFitWidth = true
        productName.text = "           "
    }
    
    private func setupLayers() {
        
        productLayer.startPoint = CGPoint(x: 0, y: 0.5)
        productLayer.endPoint = CGPoint(x: 1, y: 0.5)
        productName.layer.addSublayer(productLayer)
    }
    
    private func setupAnimation() {
        let typeGroup = makeAnimationGroup()
        typeGroup.beginTime = 0.0
        productLayer.add(typeGroup, forKey: "backgroundColor")
        
    }
    
    private func layout() {
        contentView.addSubview(productName)
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            productName.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 4),
            productName.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}
