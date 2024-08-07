//
//  CategoryMenuCollectionViewCell.swift
//  DevPoliChallenge
//
//  Created by Felipe Miranda Santos on 26/07/24.
//  Copyright © 2024 DevPoli. All rights reserved.
//

import UIKit

class CategoryMenuCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoryButton: UIButton!
    
    
    static let identifier: String = String(describing: CategoryMenuCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configElements()
    }
    
    func configElements() {
        categoryButton.layer.cornerRadius = 8
        categoryButton.layer.borderWidth = 1
        categoryButton.layer.borderColor = UIColor.systemBlue.cgColor
        categoryButton.setTitleColor(.systemBlue, for: .normal)
        categoryButton.backgroundColor = .clear
        categoryButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
//    func setupCell(data: Produto) {
//        categoryButton.setTitle(data.category?.title, for: .normal)
//    }
    
    func setupCell(data: Category) {
        categoryButton.setTitle(data.title, for: .normal)
    }
    
    @IBAction func tappedCategoryButton(_ sender: UIButton) {
    }
    
}
