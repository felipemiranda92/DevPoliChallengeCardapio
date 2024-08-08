//
//  SugestionItemCollectionViewCell.swift
//  DevPoliChallenge
//
//  Created by Felipe Miranda Santos on 07/08/24.
//  Copyright © 2024 DevPoli. All rights reserved.
//

import UIKit

class SugestionItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleItemLabel: UILabel!
    @IBOutlet weak var descriptionItemLabel: UILabel!
    @IBOutlet weak var priceItemLabel: UILabel!
    
    static let identifier: String = String(describing: SugestionItemCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configElements()
    }
    
    func configElements() {
//        descriptionItemLabel.numberOfLines = 0
//        descriptionItemLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupCell(data: Produto) {
        titleItemLabel.text = data.title
        descriptionItemLabel.text = data.description
        if let price = data.price {
            priceItemLabel.text = String(format: "R$ %.2f", price)
        } else {
            priceItemLabel.text = nil
        }
    }
    
}
