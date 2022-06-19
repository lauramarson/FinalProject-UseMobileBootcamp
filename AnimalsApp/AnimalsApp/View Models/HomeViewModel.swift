//
//  HomeViewModel.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 15/06/22.
//

import Foundation

class HomeViewModel {
    private var webServices: WebServicesContract
    private var coreData: CoreDataContract
    var animals = [Animal]()
    
    init(webServices: WebServicesContract = WebServices(), coreData: CoreDataContract = CoreData.shared) {
        self.webServices = webServices
        self.coreData = coreData
        coreData.delegate.append(self)
    }
    
    func numberOfRows() -> Int {
        return animals.count
    }
    
    func modelAt(_ index: Int) -> Animal {
        return animals[index]
    }
    
    func getAllAnimals(completion: @escaping () -> ()) {
        webServices.fetchAnimals() { [weak self] (result) in
            switch result {
            case .success(let animals):
                self?.handleAnimalResponse(with: animals)
                self?.setFavorite()
            case .failure(let error):
                //obs criar alerta
                print(error.localizedDescription)
            }
        
            completion()
        }
    }
    
    private func handleAnimalResponse(with animals: [Animal]) {
        self.animals = animals.filter { animal in
            if let name = animal.name {
                return !name.isEmpty
            }
            return false
        }
    }
    
    //MARK: Core Data Methods
    
    private func setFavorite() {
        for (index, animal) in animals.enumerated() {
            guard let id = animal.id else { return }
            animals[index].isFavorite = coreData.isFavorite(id: id)
        }
    }
    
    func addOrRemoveFavorite(at index: Int, with image: Data) {
        animals[index].imageData = image
        
        guard let isFavorite = animals[index].isFavorite,
              let id = animals[index].id else { return }
        isFavorite ? coreData.removeFavorite(id: id) : coreData.addFavorite(animals[index])
        
        animals[index].isFavorite = !isFavorite
    }
    
    func loadFavorites(completion: @escaping () -> ()) {
        coreData.loadFavoriteAnimals {
            completion()
        }
    }
    
    func saveChangesInCoreData() {
        coreData.saveChanges()
    }
}

extension HomeViewModel: UpdateDelegateProtocol {
    func updateFavoriteAnimals() {
//        setFavorite()
    }
}
