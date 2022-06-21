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
    var id: String?
    var name: String?
    var description: String?
    var age: Int?
    var species: String?
    var image: String?
    var createdAt: String?
    var updatedAt: String?
    var isFavorite: Bool? = false
    var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case age
        case species
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
//        init(from decoder: Decoder) throws {
//            let label = try decoder.singleValueContainer().decode(String.self)
//            self = CodingKeys(rawValue: label) ?? .unsupported
//        }
    }
    
    
}

extension Animal {
    
    var imageURL: URL {
        guard let imageURL = URL(string: self.image ?? "") else {
            return URL(fileURLWithPath: "")
        }
        return imageURL
    }
}

extension Animal {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let resultInt = try? values.decodeIfPresent(Int.self, forKey: .age) {
            age = resultInt
        } else {
            if let resultString = try? values.decodeIfPresent(String.self, forKey: .age) {
                age = Int(resultString) ?? 0
            }
        }
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        species = try values.decodeIfPresent(String.self, forKey: .species)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
    }
}
