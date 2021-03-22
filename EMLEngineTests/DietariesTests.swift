//
//  DietariesTests.swift
//  EMLEngine
//
//  Created by Brett Christian on 19/03/21.
//

import Foundation
import XCTest
@testable import EMLEngine


class DietariesTests: XCTestCase {
    
    func test_dietaryWithPreferred_needsCheckFalse() {
        let sut = Dietaries(name: "", color: "", type: .prefered)
        XCTAssertFalse(sut.needsCheck)
    }
    
    func test_dietaryWithAllergy_needsCheckTrue() {
        let sut = Dietaries(name: "", color: "", type: .allergy)
        XCTAssertTrue(sut.needsCheck)
    }
    
    func test_dietaryWithChokingHazard_needsCheckTrue() {
        let sut = Dietaries(name: "", color: "", type: .chokingHazard)
        XCTAssertTrue(sut.needsCheck)
    }
}
