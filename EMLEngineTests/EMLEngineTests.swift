//
//  EMLEngineTests.swift
//  EMLEngineTests
//
//  Created by Brett Christian on 24/02/21.
//

import XCTest
@testable import EMLEngine

class EMLEngineTests: XCTestCase {
    
    func test_newSchool_hasCorrectName() {
        let sut = School("school name")
        
        XCTAssertEqual(sut.name, "school name")
    }
}
