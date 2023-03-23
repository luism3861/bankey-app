//
//  ProductCell.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 11/03/23.
//

import UIKit


class ProductCell: UITableViewCell{
    struct ViewModelProduct{
        let titleProduct: String
    }
    
    let viewModel: ViewModelProduct? = nil
    let titleProductLabel = UILabel()
    
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
        titleProductLabel.translatesAutoresizingMaskIntoConstraints = false
        titleProductLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleProductLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(titleProductLabel)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            titleProductLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            titleProductLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
    }
}


extension ProductCell{
    func configure(with viewModel: ViewModelProduct){
        titleProductLabel.text = viewModel.titleProduct
    }
}
