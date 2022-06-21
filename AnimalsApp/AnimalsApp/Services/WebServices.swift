//
//  WebServices.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 15/06/22.
//

import Foundation
import Alamofire

protocol WebServicesContract: AnyObject {
    var endpoint: String { get }
    func fetchAnimals(completion: @escaping (Result<[Animal], Error>) -> ())
    func registerAnimal(with parameters: Animal, completion: @escaping (Result<Void, Error>) -> Void)
}

class WebServices: WebServicesContract {
    let endpoint: String =   "https://bootcamp-ios-api.herokuapp.com/api/v1/animals"
    
    func fetchAnimals(completion: @escaping (Result<[Animal], Error>) -> ()) {
        
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: Animals.self) { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data.items))
                case .failure(let error):
                    completion(.failure(error))
                    print(error)
                }
            }
    }
    
    func registerAnimal(with parameters: Animal, completion: @escaping (Result<Void, Error>) -> Void) {
        
        AF.request(endpoint,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).response { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
