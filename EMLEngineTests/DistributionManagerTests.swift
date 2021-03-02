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
        let distributionManager = makeDistributionManager()

        XCTAssertEqual(distributionManager.schools.count, 2)
        XCTAssertEqual(distributionManager.classroomCount, 10)
        XCTAssertEqual(distributionManager.mealCount, 50)
    }
    
    func test_demoModelController_withOneSearchParameter_returnsCorrectMealCount() {
        let distributionManager = makeDistributionManager()

        let dietaryRequirement = [Dietaries(name: "No Fish", color: "yellow")]

        XCTAssertEqual(distributionManager.allMeals.count, 50)
        XCTAssertEqual(distributionManager.countMealsContaining(dietaryRequirement), 20)
    }
    
    func test_demoModelController_withTwoSearchParameters_returnsCorrectMealCount() {

        let dietaryRequirement: [Dietaries] = [Dietaries(name: "No Fish", color: "yellow"), Dietaries(name: "No Meat", color: "red")]
        
        XCTAssertEqual(makeDistributionManager().countMealsContaining(dietaryRequirement), 40)
    }
    
    func test_distributionManager_withTwoSearchParameters_returnsMealCountMatchingAll() {
        let dietaryRequirement = [Dietaries(name: "No raw Onion", color: "yellow"), Dietaries(name: "Vegan", color: "red")]
        
        XCTAssertEqual(makeDistributionManager().countMealsMatching(dietaryRequirement), 0)
    }
    
    func test_distributionManager_withOrder_returnsCorrectBoxCountForClassroom() {
        XCTAssertEqual(makeDistributionManager().schools.first?.classrooms.first?.packMeals(with: [.boxTwelve, .boxSix]).count, 1)
    }
    
    func test_order_returnsCorrectNumberAndSizeOfContainers() {
        XCTAssertEqual(makeDistributionManager().schools.last?.packMeals(with: [.boxTwelve, .boxSix]).count, 5)
    }
}
