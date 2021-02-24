//
//  EMLEngineTests.swift
//  EMLEngineTests
//
//  Created by Brett Christian on 24/02/21.
//

import XCTest
@testable import EMLEngine

class DistributionManagerTests: XCTestCase {
    
    func test_demoModelController_countsFiftyMeals() {
        let distributionManager = makeDemoDistributionManager()

        XCTAssertEqual(distributionManager.schools.count, 2)
        XCTAssertEqual(distributionManager.classroomCount, 10)
        XCTAssertEqual(distributionManager.mealCount, 50)
    }
    
    func test_demoModelController_withOneSearchParameter_returnsCorrectMealCount() {
        let distributionManager = makeDemoDistributionManager()

        let dietaryRequirement = [Dietaries(name: "No Fish", color: "yellow")]

        XCTAssertEqual(distributionManager.allMeals.count, 50)
        XCTAssertEqual(distributionManager.countMealsWith(dietaryRequirement), 20)
    }
    
    func test_demoModelController_withTwoSearchParameters_returnsCorrectMealCount() {

        let dietaryRequirement: [Dietaries] = [Dietaries(name: "No Fish", color: "yellow"), Dietaries(name: "No Meat", color: "red")]
        
        XCTAssertEqual(makeDemoDistributionManager().countMealsWith(dietaryRequirement), 40)
    }
}
