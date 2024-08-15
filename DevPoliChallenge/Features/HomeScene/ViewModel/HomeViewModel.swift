//
//  HomeViewModel.swift
//  DevPoliChallenge
//
//  Created by Felipe Miranda Santos on 26/07/24.
//  Copyright © 2024 DevPoli. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    private var service = MenuService()
    private var menu: Menu?
    private var uniqueCategories: [Category] = []
    private var productsByCategory: [Category: [Produto]] = [:]

    
    func fetchMenu(completion: @escaping () -> Void) {
        service.getMenuMock { result in
            switch result {
                case .success(let success):
                    self.menu = success
                    self.extractUniqueCategories()
                    self.mapProductsByCategory()
                    completion()
                case .failure(let failure):
                    print(failure.localizedDescription)
                    completion()
            }
        }
    }

    func extractUniqueCategories() {
        guard let produtos = menu?.produtos else { return }
        var categorySet = Set<Category>()
        
        for produto in produtos {
            if let category = produto.category {
                categorySet.insert(category)
            }
        }
        
        uniqueCategories = Array(categorySet).sorted { $0.id ?? 0 < $1.id ?? 0 }
    }
    
    private func mapProductsByCategory() {
        guard let produtos = menu?.produtos else { return }
        
        for produto in produtos {
            guard let category = produto.category else { continue }
            if productsByCategory[category] != nil {
                productsByCategory[category]?.append(produto)
            } else {
                productsByCategory[category] = [produto]
            }
        }
    }
    
    func getCategories(section: Int) -> String {
        return uniqueCategories[section].title ?? ""
    }
    
    func getNumberOfSections() -> Int {
        return uniqueCategories.count
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        let category = uniqueCategories[section]
        return productsByCategory[category]?.count ?? 0
    }

    func numberOfRows() -> Int {
        return uniqueCategories.count
    }
    
    func getItemMenu(indexPath: IndexPath) -> Category? {
        if indexPath.row < uniqueCategories.count {
            return uniqueCategories[indexPath.row]
        } else {
            return nil
        }
    }
    
    func getMenuProducts(indexPath: IndexPath) -> Produto? {
        let category = uniqueCategories[indexPath.section]
        return productsByCategory[category]?[indexPath.row]
    }
    
    func getProductsForCategory(category: Category) -> [Produto] {
        return productsByCategory[category] ?? []
    }

}
