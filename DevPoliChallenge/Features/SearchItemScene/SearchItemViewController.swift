//
//  SearchItemViewController.swift
//  DevPoliChallenge
//
//  Created by Felipe Miranda Santos on 05/08/24.
//  Copyright © 2024 DevPoli. All rights reserved.
//

import UIKit

class SearchItemViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configTableview()
    }
    
    func configTableview() {
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(RestaurantMenuTableViewCell.nib(), forCellReuseIdentifier: RestaurantMenuTableViewCell.identifier)
    }

}

extension SearchItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        <#code#>
//    }
    
    
}
