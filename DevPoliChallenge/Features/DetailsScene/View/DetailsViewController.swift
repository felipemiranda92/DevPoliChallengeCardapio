//
//  DetailsViewController.swift
//  DevPoliChallenge
//
//  Created by Felipe Miranda Santos on 02/08/24.
//  Copyright © 2024 DevPoli. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleProductLabel: UILabel!
    @IBOutlet weak var categoryProductLabel: UILabel!
    @IBOutlet weak var descriptionProductLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var homeButton: UIButton!
    
    var itemMenu: Produto?
    var suggestedProducts: [Produto] = []
    
    init?(coder: NSCoder, itemMenu: Produto) {
        self.itemMenu = itemMenu
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailsScreen()
        configCollectionView()
        configElements()
    }
    
    
    @IBAction func tappedHomeButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func configElements() {
        
        if let homeImage = UIImage(systemName: "house.fill") {
            
            homeButton.setTitle("", for: .normal)
            homeButton.setImage(homeImage, for: .normal)
            homeButton.tintColor = .systemBlue 
            
            titleProductLabel.numberOfLines = 1
            titleProductLabel.lineBreakMode = .byClipping
            titleProductLabel.adjustsFontSizeToFitWidth = true
            titleProductLabel.minimumScaleFactor = 0.5
            
            categoryProductLabel.numberOfLines = 1
            categoryProductLabel.lineBreakMode = .byClipping
            categoryProductLabel.adjustsFontSizeToFitWidth = true
            categoryProductLabel.minimumScaleFactor = 0.5
            
            descriptionProductLabel.numberOfLines = 0
            descriptionProductLabel.lineBreakMode = .byWordWrapping
            descriptionProductLabel.adjustsFontSizeToFitWidth = true
            descriptionProductLabel.minimumScaleFactor = 0.5
            
            priceProductLabel.numberOfLines = 1
            priceProductLabel.lineBreakMode = .byClipping
            priceProductLabel.adjustsFontSizeToFitWidth = true
            priceProductLabel.minimumScaleFactor = 0.5
        }
    }
    
    
    func setupDetailsScreen() {
        titleProductLabel.text = itemMenu?.title
        categoryProductLabel.text = itemMenu?.category?.title
        descriptionProductLabel.text = itemMenu?.description
        if let price = itemMenu?.price {
            priceProductLabel.text = String(format: "R$ %.2f", price)
        } else {
            priceProductLabel.text = nil
        }
        
        fetchSuggestedProducts()
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: 50)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(SugestionItemCollectionViewCell.nib(), forCellWithReuseIdentifier: SugestionItemCollectionViewCell.identifier)
    }
    
    func fetchSuggestedProducts() {
        guard let category = itemMenu?.category else { return }
        
        let homeViewModel = HomeViewModel()
        homeViewModel.fetchMenu {
            self.suggestedProducts = homeViewModel.getProductsForCategory(category: category).filter { $0.id != self.itemMenu?.id }
            self.collectionView.reloadData()
        }
    }

}


extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SugestionItemCollectionViewCell.identifier, for: indexPath) as? SugestionItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let product = suggestedProducts[indexPath.row]
        cell.setupCell(data: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedProduct = suggestedProducts[indexPath.row]
        
        let detailsScreen = UIStoryboard(name: String(describing: DetailsViewController.self), bundle: nil).instantiateViewController(identifier: String(describing: DetailsViewController.self)) { coder -> DetailsViewController? in
            return DetailsViewController(coder: coder, itemMenu: selectedProduct)
        }
        detailsScreen.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(detailsScreen, animated: true)
    }

}

