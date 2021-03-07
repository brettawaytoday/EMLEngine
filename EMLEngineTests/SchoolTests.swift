//
//  SchoolTests.swift
//  EMLEngineTests
//
//  Created by Brett Christian on 24/02/21.
//

import XCTest
@testable import EMLEngine

class SchoolTests: XCTestCase {

    func test_newSchool_hasCorrectName() {
        XCTAssertEqual(makeSchool().name, "school name")
    }
    
    func test_addClassroomToSchool_rendersCorrectAllocations() {
        let school = makeSchool()
        
        let classroom = makeClassroom()
        
        addClassroom(classroom, to: school)
        
        XCTAssertEqual(school.classrooms.count, 1)
        XCTAssertEqual(classroom.school?.name, school.name)
        XCTAssertEqual(school.classrooms.first?.name, "classroom name")
    }
    
    func test_addMealToClassroom_rendersCorrectAllocations() {
        let classroom = makeClassroom()
        let meal = makeMealWithDietaries_noFish_vegan()
        
        addMeal(meal, to: classroom)
        
        XCTAssertEqual(classroom.meals.count, 1)
        XCTAssertEqual(meal.classroom?.name, classroom.name)
    }
    
    func test_addTwoMealsToClassroom_reternsMealCountOfTwo() {
        let classroom = makeClassroom()
        let meal = makeMealWithDietaries_noFish_vegan()
        
        addMeal(meal, to: classroom)
        addMeal(meal, to: classroom)
        
        XCTAssertEqual(classroom.meals.count, 2)
    }
}

