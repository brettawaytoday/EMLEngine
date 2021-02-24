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
        XCTAssertEqual(classroom.school!.name, school.name)
        XCTAssertEqual(classroom.name, "classroom name")
    }
    
    func test_addMealToClassroom_rendersCorrectAllocations() {
        let classroom = makeClassroom()
        let meal = makeMealWithDietaries()
        
        addMeal(meal, to: classroom)
        
        XCTAssertEqual(classroom.meals.count, 1)
        XCTAssertEqual(meal.classroom!.name, classroom.name)
    }
    
    func test_addTwoMealsToClassroom_reternsMealCountOfTwo() {
        let classroom = makeClassroom()
        let meal = makeMealWithDietaries()
        
        addMeal(meal, to: classroom)
        addMeal(meal, to: classroom)
        
        XCTAssertEqual(classroom.meals.count, 2)
    }
    
    //MARK: Helpers
    
    func makeSchool() -> School {
        return School("school name")
    }
    
    func makeClassroom() -> Classroom {
        return Classroom("classroom name")
    }
    
    func makeMealWithDietaries() -> Meal {
        let noFish = Dietaries(name: "No Fish", color: "yellow")
        let vegan = Dietaries(name: "Vegan", color: "red")
        
        return Meal(.regular, dietaries: [noFish, vegan])
    }

}
