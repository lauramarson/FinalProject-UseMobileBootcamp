//
//  HomeViewModel.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 15/06/22.
//

import Foundation

class HomeViewModel {
    private var webServices: WebServicesContract
    var animals = [Animal]()
    
    init(webServices: WebServicesContract = WebServices()) {
        self.webServices = webServices
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
}
