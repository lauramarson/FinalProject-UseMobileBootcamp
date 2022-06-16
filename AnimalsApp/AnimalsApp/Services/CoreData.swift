//
//  CoreData.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 16/06/22.
//

import UIKit
import CoreData

class CoreData {
    var managedContext: NSManagedObjectContext?
    var favoriteAnimals = [FavoriteAnimal]()
    
    init() {
        managedContext = (UIApplication.shared.delegate as? AppDelegate)?
            .persistentContainer
            .viewContext
    }
    
    func loadFavoriteAnimals(completion: @escaping () -> ()) {
        guard let managedContext = managedContext else { return }
        
        let fetchRequest: NSFetchRequest<FavoriteAnimal> = FavoriteAnimal.fetchRequest()

        do {
            favoriteAnimals = try managedContext.fetch(fetchRequest)
            completion()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func isFavorite(id: String) -> Bool {
        
        for animal in favoriteAnimals {
            if animal.id == id {
                return true
            }
        }
        return false
    }

    func addFavorite(_ animal: Animal) {

        guard let managedContext = managedContext else { return }
        
        let newFavoriteAnimal = FavoriteAnimal(context: managedContext)
        newFavoriteAnimal.id = animal.id
        newFavoriteAnimal.name = animal.name
        newFavoriteAnimal.image = animal.imageData
        newFavoriteAnimal.descript = animal.description
        newFavoriteAnimal.age = Int32(animal.age ?? 0)
        newFavoriteAnimal.species = animal.species
        self.favoriteAnimals.append(newFavoriteAnimal)
    }

    func removeFavorite(id: String) {

        guard let managedContext = managedContext else { return }
        
        var removeAnimal = FavoriteAnimal()
        
        for (index, animal) in favoriteAnimals.enumerated() {
            if animal.id == id {
                removeAnimal = animal
                favoriteAnimals.remove(at: index)
            }
        }
        
        managedContext.delete(removeAnimal)
    }

    func saveChanges() {
        do {
            try self.managedContext?.save()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
}
