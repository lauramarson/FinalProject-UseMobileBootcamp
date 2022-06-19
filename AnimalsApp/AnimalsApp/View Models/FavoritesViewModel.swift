//
//  FavoritesViewModel.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 18/06/22.
//

import Foundation
 
class FavoritesViewModel {
    let coreData: CoreDataContract
    
    var favoriteAnimals = [Animal]()
    private var newCoreDataChanges = true
    
    init(coreData: CoreDataContract = CoreData.shared) {
        self.coreData = coreData
        coreData.delegate.append(self)
    }
    
    func getFavoriteAnimals(completion: @escaping () -> Void) {
        guard newCoreDataChanges else { return }
        
        favoriteAnimals = coreData.favoriteAnimals.map { favoriteAnimal in
            Animal(id: favoriteAnimal.id, name: favoriteAnimal.name, description: favoriteAnimal.descript, age: Int(favoriteAnimal.age), species: favoriteAnimal.species, isFavorite: true, imageData: favoriteAnimal.image)
        }
        
        newCoreDataChanges = false
        completion()
    }
    
    func numberOfRows() -> Int {
        return favoriteAnimals.count
    }
    
    func modelAt(_ index: Int) -> Animal {
        return favoriteAnimals[index]
    }
    
    func removeFavorite(at index: Int, completion: @escaping () -> Void) {
        guard let id = favoriteAnimals[index].id else { return }
        favoriteAnimals.remove(at: index)
        coreData.removeFavorite(id: id)
        completion()
    }
}

extension FavoritesViewModel: UpdateDelegateProtocol {
    func updateFavoriteAnimals() {
        newCoreDataChanges = true
    }
    
}
