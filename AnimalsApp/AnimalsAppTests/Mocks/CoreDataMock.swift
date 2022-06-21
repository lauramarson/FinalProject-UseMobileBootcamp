//
//  CoreDataMock.swift
//  AnimalsAppTests
//
//  Created by Laura Pinheiro Marson on 21/06/22.
//

import Foundation
@testable import AnimalsApp
import XCTest

class CoreDataMock: CoreDataContract {
    var delegate = [UpdateDelegateProtocol]()
    var favoriteAnimals = [FavoriteAnimal]()
    
    var loadedFavoriteAnimals = [Animal]()
    
    func loadFavoriteAnimals(completion: @escaping () -> ()) {
        for n in 1...10 {
            let favoriteAnimal = Animal(id: "\(n)", name: "Animal \(n)", description: "Esse é o animal de número \(n)", age: 5, species: "Espécie X", createdAt: "Dia X", updatedAt: "Dia Y", isFavorite: true)
            loadedFavoriteAnimals.append(favoriteAnimal)
        }
        completion()
    }
    
    func isFavorite(id: String) -> Bool {
        return false
    }
    
    func addFavorite(_ animal: Animal) {
        
    }
    
    func removeFavorite(id: String) {
        
    }
    
    func saveChanges() {
        
    }
    
    
}
