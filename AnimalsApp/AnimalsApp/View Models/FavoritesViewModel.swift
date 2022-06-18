//
//  FavoritesViewModel.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 18/06/22.
//

import Foundation
 
class FavoritesViewModel {
    var favoriteAnimals = [Animal]()
    
    func getFavoriteAnimals(completion: @escaping () -> Void) {
        let coreDataAnimals = CoreData.favoriteAnimals
        favoriteAnimals.removeAll(keepingCapacity: true)
        
        coreDataAnimals.forEach { favoriteAnimal in
            let newAnimal = Animal(id: favoriteAnimal.id, name: favoriteAnimal.name, description: favoriteAnimal.descript, age: Int(favoriteAnimal.age), species: favoriteAnimal.species, isFavorite: true, imageData: favoriteAnimal.image)
            favoriteAnimals.append(newAnimal)
        }
        
        completion()
    }
    
    func numberOfRows() -> Int {
        return favoriteAnimals.count
    }
    
    func modelAt(_ index: Int) -> Animal {
        return favoriteAnimals[index]
    }
}
