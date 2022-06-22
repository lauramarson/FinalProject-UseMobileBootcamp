//
//  HomeViewModel.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 15/06/22.
//

import Foundation

class HomeViewModel {
    //MARK: Properties
    private var webServices: WebServicesContract
    private var coreData: CoreDataContract
    var animals = [Animal]()
    
    //MARK: Initialization
    init(webServices: WebServicesContract = WebServices(), coreData: CoreDataContract = CoreData.shared) {
        self.webServices = webServices
        self.coreData = coreData
        coreData.delegate.append(self)
    }
    
    //MARK: Methods
    func numberOfRows() -> Int {
        return animals.count
    }
    
    func modelAt(_ index: Int) -> Animal {
        return animals[index]
    }
    
    func getAllAnimals(completion: @escaping (Result<Void, Error>) -> ()) {
        webServices.fetchAnimals() { [weak self] (result) in
            switch result {
            case .success(let animals):
                self?.handleAnimalResponse(with: animals)
                self?.setFavorite()
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
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
    
    func removeFavorite(at index: Int) {
        guard let id = animals[index].id else { return }
        coreData.removeFavorite(id: id)
        animals[index].isFavorite = false
    }
    
    func addFavorite(at index: Int, with image: Data) {
        animals[index].imageData = image
        coreData.addFavorite(animals[index])
        animals[index].isFavorite = true
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

//MARK: Update Delegate Protocol
extension HomeViewModel: UpdateDelegateProtocol {
    func updateFavoriteAnimals() {
        setFavorite()
    }
}
