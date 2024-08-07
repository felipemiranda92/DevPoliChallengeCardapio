//
//  ViewController.swift
//  DevPoliChallenge
//
//  Created by DevPoli on 29/07/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        configCollectionView()
        configTableView()
        viewModel.fetchMenu {
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RestaurantMenuTableViewCell.nib(), forCellReuseIdentifier: RestaurantMenuTableViewCell.identifier)
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
        collectionView.register(CategoryMenuCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryMenuCollectionViewCell.identifier)
    }

    func configSearchBar() {
        searchBar.delegate = self
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantMenuTableViewCell.identifier, for: indexPath) as? RestaurantMenuTableViewCell else {
            return UITableViewCell()
        }
        
        if let produto = viewModel.getMenuProducts(indexPath: indexPath) {
            cell.setupCell(data: produto)
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getCategories(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let produto = viewModel.getMenuProducts(indexPath: indexPath) else {
            return
        }
        
        let detailsScreen = UIStoryboard(name: String(describing: DetailsViewController.self), bundle: nil).instantiateViewController(identifier: String(describing: DetailsViewController.self)) { coder -> DetailsViewController? in
            return DetailsViewController(coder: coder, itemMenu: produto)
        }
        
        self.navigationController?.pushViewController(detailsScreen, animated: true)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryMenuCollectionViewCell.identifier, for: indexPath) as? CategoryMenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let item = viewModel.getItemMenu(indexPath: indexPath) {
            cell.setupCell(data: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.row
        let indexPath = IndexPath(row: NSNotFound, section: section)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}


extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let SearchItemScreen = UIStoryboard(name: String(describing: SearchItemViewController.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: SearchItemViewController.self)) as? SearchItemViewController
//        SearchItemScreen?.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(SearchItemScreen ?? UIViewController(), animated: true)
    }
    
    //uitapgesture

}

