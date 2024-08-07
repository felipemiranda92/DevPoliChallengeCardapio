//
//  MenuService.swift
//  DevPoliChallenge
//
//  Created by Felipe Miranda Santos on 26/07/24.
//  Copyright © 2024 DevPoli. All rights reserved.
//

import Foundation


class MenuService {
    
    func getMenuMock(completion: (Result<Menu, Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "Cardapio", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let menu: Menu = try JSONDecoder().decode(Menu.self, from: data)
                completion(.success(menu))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
}
