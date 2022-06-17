//
//  StringExtensionTests.swift
//  AnimalsAppTests
//
//  Created by Laura Pinheiro Marson on 17/06/22.
//

import XCTest
@testable import AnimalsApp

class StringExtensionTests: XCTestCase {

    func testIfIsEmptyExtensionReturnsNil() {
        let emptyString = ""
        let result = emptyString.testIfIsEmpty()
        
        XCTAssertNil(result)
    }
    
    func testIfIsEmptyExtensionReturnsSelf() {
        let string = "string"
        let result = string.testIfIsEmpty()
        
        XCTAssertEqual(string, result)
    }

}
