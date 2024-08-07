//
//  RestaurantMenuTableViewCell.swift
//  DevPoliChallenge
//
//  Created by Felipe Miranda Santos on 26/07/24.
//  Copyright © 2024 DevPoli. All rights reserved.
//

import UIKit

class RestaurantMenuTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleProductLabel: UILabel!
    @IBOutlet weak var descriptionProductLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    
    static let identifier: String = String(describing: RestaurantMenuTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(data: Produto) {
        titleProductLabel.text = data.title
        descriptionProductLabel.text = data.description
        if let price = data.price {
            priceProductLabel.text = String(format: "R$ %.2f", price)
        } else {
            priceProductLabel.text = nil
        }
    }
    
}
