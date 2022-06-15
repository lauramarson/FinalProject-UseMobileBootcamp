//
//  WebServices.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 15/06/22.
//

import Foundation
import Alamofire

protocol WebServicesContract: AnyObject {
    func fetchAnimals(completion: @escaping (Result<[Animal], Error>) -> ())
    func registerAnimal()
}

class WebServices: WebServicesContract {
    let urlString = "https://bootcamp-ios-api.herokuapp.com/api/v1/animals"
    
    func fetchAnimals(completion: @escaping (Result<[Animal], Error>) -> ()) {
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: Animals.self) { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data.items))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func registerAnimal() {
        
    }
}
