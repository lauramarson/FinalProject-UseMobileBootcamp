//
//  RegisterViewModel.swift
//  AnimalsApp
//
//  Created by Fran Martins on 15/06/22.
//

import Foundation

struct RegisterViewModel {
    //MARK: Properties
    private var webServices: WebServicesContract
    
    //MARK: Initialization
    init(webServices: WebServicesContract = WebServices()) {
        self.webServices = webServices
    }
    
    //MARK: Methods
    func registerAnimal(name: String, description: String, age: Int, species: String, image: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        let newAnimal = Animal(name: name, description: description, age: age, species: species, image: image)
        
        webServices.registerAnimal(with: newAnimal) { (result) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
