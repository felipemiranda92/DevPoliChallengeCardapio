//
//  MenuModel.swift
//  DevPoliChallenge
//
//  Created by Felipe Miranda Santos on 26/07/24.
//  Copyright © 2024 DevPoli. All rights reserved.
//

import Foundation


// MARK: - Menu
struct Menu: Codable {
    var produtos: [Produto]?
}

// MARK: - Produto
struct Produto: Codable {
    var id: Int?
    var title, description: String?
    var price: Double?
    var category: Category?
}

//// MARK: - Category
//struct Category: Codable {
//    var id: Int?
//    var title: String?
//}

// MARK: - Category
struct Category: Codable, Hashable, Equatable {
    var id: Int?
    var title: String?
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
}
