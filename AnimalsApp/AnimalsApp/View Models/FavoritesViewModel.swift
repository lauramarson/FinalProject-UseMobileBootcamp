//
//  FavoritesViewModel.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 18/06/22.
//

import Foundation
 
class FavoritesViewModel {
    var favoriteAnimals = [Animal]()
    let coreData: CoreDataContract
    
    init(coreData: CoreDataContract = CoreData.shared) {
        self.coreData = coreData
    }
    
    func getFavoriteAnimals(completion: @escaping () -> Void) {

        favoriteAnimals = coreData.favoriteAnimals.map { favoriteAnimal in
            Animal(id: favoriteAnimal.id, name: favoriteAnimal.name, description: favoriteAnimal.descript, age: Int(favoriteAnimal.age), species: favoriteAnimal.species, isFavorite: true, imageData: favoriteAnimal.image)
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
