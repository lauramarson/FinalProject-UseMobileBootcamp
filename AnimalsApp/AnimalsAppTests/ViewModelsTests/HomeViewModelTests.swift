//
//  HomeViewModelTests.swift
//  AnimalsAppTests
//
//  Created by Laura Pinheiro Marson on 17/06/22.
//

import XCTest
@testable import AnimalsApp

class HomeViewModelTests: XCTestCase {

    var successWebService = SuccessWebService()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        successWebService = SuccessWebService()
    }

    func testAnimalsCountAfterServiceCall() throws {
        
        let viewModel = HomeViewModel(webServices: successWebService)
        
        viewModel.getAllAnimals { }
        
        XCTAssertEqual(viewModel.numberOfRows(), successWebService.fetchedAnimals.count)
    }
    
    func testIfReturnedModelIsCorrect() throws {

        let viewModel = HomeViewModel(webServices: successWebService)
        
        viewModel.getAllAnimals { }
        
        let returnedAnimal = viewModel.modelAt(6)
        
        XCTAssertEqual(returnedAnimal.id, successWebService.fetchedAnimals[6].id)
    }

}
