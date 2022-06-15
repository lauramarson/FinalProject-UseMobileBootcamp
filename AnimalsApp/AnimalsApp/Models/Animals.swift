//
//  Items.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 15/06/22.
//

import Foundation

struct Animals: Codable {
    var items: [Animal]
}

struct Animal: Codable {
    let id: String
    let name: String?
    let description: String?
    let age: Int?
    let species: String?
    let image: String?
    let created_at: String
    var updated_at: String
    var isFavorite: Bool? = false
}

extension Animal {
    
    var imageURL: URL {
        guard let imageURL = URL(string: self.image ?? "") else {
            return URL(fileURLWithPath: "")
        }
        return imageURL
    }
}
