//
//  ProductCell.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 11/03/23.
//

import UIKit


class ProductCell: UITableViewCell{
    struct ViewModelProduct{
        let nameComment: String
    }
    
    let viewModel: ViewModelProduct? = nil
    let nameProductLabel = UILabel()
    
    static let reuseIDProduct = "ProductCell"
    static let rowHeight: CGFloat = 80
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ProductCell{
    private func setup(){
        nameProductLabel.translatesAutoresizingMaskIntoConstraints = false
        nameProductLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        nameProductLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(nameProductLabel)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            nameProductLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            nameProductLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
    }
}


extension ProductCell{
    func configure(with viewModel: ViewModelProduct){
        nameProductLabel.text = viewModel.nameComment
    }
}
