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
    func registerAnimal(with parameters: [String: Any], handler: @escaping (() -> Void))
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
                }
            }
    }
    
    func registerAnimal(with parameters: [String: Any], handler: @escaping (() -> Void)) {
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
                switch response.result {
                    case .success(let data):
                    handler()
                        do {
                            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                                print("Error: Cannot convert data to JSON object")
                                return
                            }
                            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                                print("Error: Cannot convert JSON object to Pretty JSON data")
                                return
                            }
                            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                                print("Error: Could print JSON in String")
                                return
                            }

                            print(prettyPrintedJson)
                        } catch {
                            print("Error: Trying to convert JSON data to string")
                            return
                        }
                    case .failure(let error):
                    handler()
                        print(error)
                }
            }
    }
}
