//
//  RegisterViewModelTests.swift
//  AnimalsAppTests
//
//  Created by Laura Pinheiro Marson on 17/06/22.
//

import XCTest
@testable import AnimalsApp

class RegisterViewModelTests: XCTestCase {

    var successWebService = SuccessWebService()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        successWebService = SuccessWebService()
    }

    func testAnimalsCountAfterServiceCall() throws {
        
        let viewModel = RegisterViewModel(webServices: successWebService)
        
        viewModel.registerAnimal(name: "", description: "", age: 0, species: "", image: "") { }
        
        XCTAssertTrue(successWebService.registerAnimalCalled)
    }

}
