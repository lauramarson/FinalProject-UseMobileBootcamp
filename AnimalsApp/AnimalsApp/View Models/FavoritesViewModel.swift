//
//  FavoritesViewModel.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 18/06/22.
//

import Foundation
 
class FavoritesViewModel {
    //MARK: Properties
    let coreData: CoreDataContract
    
    var favoriteAnimals = [Animal]()
    private var newCoreDataChanges = true
    
    //MARK: Initialization
    init(coreData: CoreDataContract = CoreData.shared) {
        self.coreData = coreData
        coreData.delegate.append(self)
    }
    
    //MARK: Methods
    func numberOfRows() -> Int {
        return favoriteAnimals.count
    }
    
    func modelAt(_ index: Int) -> Animal {
        return favoriteAnimals[index]
    }
    
    //MARK: Core Data Methods
    func getFavoriteAnimals(completion: @escaping () -> Void) {
        guard newCoreDataChanges else { return }
        
        favoriteAnimals = coreData.favoriteAnimals.map { favoriteAnimal in
            Animal(id: favoriteAnimal.id, name: favoriteAnimal.name, description: favoriteAnimal.descript, age: Int(favoriteAnimal.age), species: favoriteAnimal.species, isFavorite: true, imageData: favoriteAnimal.image)
        }
        
        newCoreDataChanges = false
        completion()
    }
    
    func removeFavorite(at index: Int, completion: @escaping () -> Void) {
        guard let id = favoriteAnimals[index].id else { return }
        favoriteAnimals.remove(at: index)
        coreData.removeFavorite(id: id)
        completion()
    }
}

//MARK: Update Delegate Protocol
extension FavoritesViewModel: UpdateDelegateProtocol {
    func updateFavoriteAnimals() {
        newCoreDataChanges = true
    }
    
}
