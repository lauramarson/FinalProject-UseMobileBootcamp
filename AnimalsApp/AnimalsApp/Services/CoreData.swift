//
//  CoreData.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 16/06/22.
//

import UIKit
import CoreData

protocol CoreDataContract: AnyObject {
    var delegate: [UpdateDelegateProtocol] { get set }
    var favoriteAnimals: [FavoriteAnimal] { get set }
    func loadFavoriteAnimals(completion: @escaping () -> ())
    func isFavorite(id: String) -> Bool
    func addFavorite(_ animal: Animal)
    func removeFavorite(id: String)
    func saveChanges()
}

protocol UpdateDelegateProtocol: AnyObject {
    func updateFavoriteAnimals()
}

class CoreData: CoreDataContract {
    static let shared = CoreData()
    
    private var managedContext: NSManagedObjectContext?
    
    var delegate = [UpdateDelegateProtocol]()
    var favoriteAnimals = [FavoriteAnimal]() {
        didSet {
            delegate.forEach { delegate in
                delegate.updateFavoriteAnimals()
            }
        }
    }
    
    private init() {
        managedContext = (UIApplication.shared.delegate as? AppDelegate)?
            .persistentContainer
            .viewContext
    }
    
    func loadFavoriteAnimals(completion: @escaping () -> ()) {
        guard let managedContext = managedContext else { return }

        let fetchRequest: NSFetchRequest<FavoriteAnimal> = FavoriteAnimal.fetchRequest()

        do {
            self.favoriteAnimals = try managedContext.fetch(fetchRequest)
            completion()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func isFavorite(id: String) -> Bool {
        
        for animal in self.favoriteAnimals {
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

        var count = 0

        for animal in self.favoriteAnimals {
            if animal.id == id {
                let removeAnimal = animal
                self.favoriteAnimals.remove(at: count)
                managedContext.delete(removeAnimal)
            }
            count += 1
        }

    }

    func saveChanges() {
        do {
            try self.managedContext?.save()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
}
