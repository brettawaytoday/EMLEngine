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

        let dietaryRequirement = [Dietaries(name: "No Fish", color: "yellow", type: .prefered)]

        XCTAssertEqual(distributionManager.allMeals.count, 50)
        XCTAssertEqual(distributionManager.countMealsContaining(dietaryRequirement), 20)
    }
    
    func test_demoModelController_withTwoSearchParameters_returnsCorrectMealCount() {

        let dietaryRequirement: [Dietaries] = [Dietaries(name: "No Fish", color: "yellow", type: .prefered), Dietaries(name: "No Meat", color: "red", type: .prefered)]
        
        XCTAssertEqual(makeDistributionManager().countMealsContaining(dietaryRequirement), 40)
    }
    
    func test_distributionManager_withTwoSearchParameters_returnsMealCountMatchingAll() {
        let dietaryRequirement = [Dietaries(name: "No raw Onion", color: "yellow", type: .prefered), Dietaries(name: "Vegan", color: "red", type: .prefered)]
        
        XCTAssertEqual(makeDistributionManager().countMealsMatching(dietaryRequirement), 0)
    }
    
    func test_distributionManager_withOrder_returnsCorrectBoxCountForClassroom() {
        XCTAssertEqual(makeDistributionManager().schools.first?.classrooms.first?.packMeals(with: [.boxTwelve, .boxSix]).count, 1)
    }
    
    func test_order_returnsCorrectNumberAndSizeOfContainers() {
        XCTAssertEqual(makeDistributionManager().schools.last?.packMeals(with: [.boxTwelve, .boxSix]).count, 5)
    }
    
    func test_order_returnAllContainersForDelivery() {
        XCTAssertEqual(makeDistributionManager().packageOrder(in: [.boxTwelve, .boxSix]).count, 10)
    }
    
    func test_largeOrder_returnAllContainersForDelivery() {
        XCTAssertEqual(makeDistributionManagerWithLargeOrder().packageOrder(in: [.boxSix]).count, 125)
        XCTAssertEqual(makeDistributionManagerWithLargeOrder().packageOrder(in: [.boxTwelve, .boxSix]).count, 75)
    }
    
    func test_orderReturns_report() {
        XCTAssertNotNil(makeDistributionManager().requestReports(packagingType: [.boxSix, .boxTwelve]))
    }
    
    func test_orderReturns_report_withSchoolReport() throws {
        let report: ReportGenerator = try XCTUnwrap(makeDistributionManager().requestReports(packagingType: [.boxSix, .boxTwelve]) as? ReportGenerator)
        XCTAssertTrue(type(of: report) == ReportGenerator.self)
        let schoolReport: SchoolReport = try XCTUnwrap(report.schools.first as? SchoolReport)
        XCTAssertTrue(type(of: schoolReport) == SchoolReport.self)
        let classroomReport: ClassroomReport = try XCTUnwrap(schoolReport.classrooms.first as? ClassroomReport)
        XCTAssertTrue(type(of: classroomReport) == ClassroomReport.self)
        let mealReport: MealReport = try XCTUnwrap(classroomReport.meals.first as? MealReport)
        XCTAssertTrue(type(of: mealReport) == MealReport.self)
    }
    
    func test_orderReturns_report_withPackagingReport() throws {
        let report: ReportGenerator = try XCTUnwrap(makeDistributionManager().requestReports(packagingType: [.boxSix, .boxTwelve]) as? ReportGenerator)
        XCTAssertTrue(type(of: report) == ReportGenerator.self)
        let schoolReport: SchoolReport = try XCTUnwrap(report.schools.first as? SchoolReport)
        XCTAssertEqual(schoolReport.search(for: .packaging).count, 5)
        let classroomReport: ClassroomReport = try XCTUnwrap(schoolReport.classrooms.first as? ClassroomReport)
        XCTAssertEqual(classroomReport.search(for: .packaging).count, 1)
    }
}
