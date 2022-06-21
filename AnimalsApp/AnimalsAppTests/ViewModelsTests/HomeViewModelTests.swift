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
    var coreDataMock = CoreDataMock()
    var viewModel: HomeViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        successWebService = SuccessWebService()
        coreDataMock = CoreDataMock()
        viewModel = HomeViewModel(webServices: successWebService, coreData: coreDataMock)
    }

    func testAnimalsCountAfterServiceCall() throws {
        
        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.getAllAnimals { _ in }
        
        XCTAssertEqual(viewModel.numberOfRows(), successWebService.fetchedAnimals.count)
    }
    
    func testIfReturnedModelIsCorrect() throws {

        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.getAllAnimals { _ in }
        
        let returnedAnimal = viewModel.modelAt(6)
        
        XCTAssertEqual(returnedAnimal.id, successWebService.fetchedAnimals[6].id)
    }
    
    func testIfIsLoadingFavoriteAnimals() throws {

        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.loadFavorites { }
        
        XCTAssertEqual(coreDataMock.loadedFavoriteAnimals.count, 10)
    }

}
