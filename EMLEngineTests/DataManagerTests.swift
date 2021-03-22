//
//  DataManager.swift
//  EMLEngine
//
//  Created by Brett Christian on 18/03/21.
//

import Foundation
import XCTest
@testable import EMLEngine

class DataManagerTests: XCTestCase {
    
    func test_distributionManager_notNil() {
        let sut = DataManager(DistributionManager())
        XCTAssertNotNil(sut.distributionManager)
    }
    
    func test_dataManager_getSchools_returnsOneSchool() {
        let school = School("School")
        let distributionManger = DistributionManager()
        distributionManger.schools = [school]
        let sut = DataManager(distributionManger)
        XCTAssertEqual(sut.getSchools().count, 1)
    }
    
    func test_dataManager_getClassrooms_returnsOneClassroom() {
        let school = School("School")
        let classroom = Classroom("Classroom")
        addClassroom(classroom, to: school)
        let distributionManger = DistributionManager()
        distributionManger.schools = [school]
        let sut = DataManager(distributionManger)
        XCTAssertEqual(sut.getClassrooms().count, 1)
    }
    
    func test_dataManager_getMeals_returnsOneMeal() {
        let school = School("School")
        let classroom = Classroom("Classroom")
        let meal = Meal(.regular, dietaries: [])
        addMeal(meal, to: classroom)
        addClassroom(classroom, to: school)
        let distributionManger = DistributionManager()
        distributionManger.schools = [school]
        let sut = DataManager(distributionManger)
        XCTAssertEqual(sut.getMeals().count, 1)
    }
    
}
