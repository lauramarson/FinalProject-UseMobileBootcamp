//
//  RegisterViewModel.swift
//  AnimalsApp
//
//  Created by Fran Martins on 15/06/22.
//

import Foundation

struct RegisterViewModel {
    private var webServices: WebServicesContract
    
    init(webServices: WebServicesContract = WebServices()) {
        self.webServices = webServices
    }
    
    func registerAnimal(with parameters: [String: Any]) {
        webServices.registerAnimal(with: parameters)
    }
}
