//
//  SuccessWebService.swift
//  AnimalsAppTests
//
//  Created by Laura Pinheiro Marson on 17/06/22.
//

import Foundation
@testable import AnimalsApp

class SuccessWebService: WebServicesContract {
    var endpoint = ""
    var fetchedAnimals = [Animal]()
    var fetchAnimalsCalled = false
    var registerAnimalCalled = false
    
    func fetchAnimals(completion: @escaping (Result<[Animal], Error>) -> ()) {
        
        for n in 1...10 {
            fetchedAnimals.append(Animal(id: "\(n)", name: "Animal \(n)", description: "Esse é o animal de número \(n)", age: 5, species: "Espécie X", image: "link", createdAt: "Dia X", updatedAt: "Dia Y"))
        }
        fetchAnimalsCalled = true
        completion(.success(fetchedAnimals))
    }
    
    func registerAnimal(with parameters: Animal, completion: @escaping (Result<Void, Error>) -> Void) {
        registerAnimalCalled = true
        completion(.success(()))
    }
    
}
