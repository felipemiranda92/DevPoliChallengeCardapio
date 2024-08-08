//
//  CategoryMenuCollectionViewCell.swift
//  DevPoliChallenge
//
//  Created by Felipe Miranda Santos on 26/07/24.
//  Copyright © 2024 DevPoli. All rights reserved.
//

import UIKit

class CategoryMenuCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    static let identifier: String = String(describing: CategoryMenuCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configElements()
    }
    
    func configElements() {
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.layer.borderWidth = 1
        categoryLabel.layer.borderColor = UIColor.systemBlue.cgColor
        categoryLabel.textColor = UIColor.systemBlue
        categoryLabel.textAlignment = .center
        categoryLabel.clipsToBounds = true
    }
        
    func setupCell(data: Category) {
        categoryLabel.text = data.title
    }
    
}
