//
//  TestHelpers.swift
//  EMLEngineTests
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation
import XCTest
@testable import EMLEngine


func makeSchool() -> School {
    return School("school name")
}

func makeClassroom() -> Classroom {
    return Classroom("classroom name")
}

func makeMealWithDietaries_noFish_vegan() -> Meal {
    let noFish = Dietaries(name: "No Fish", color: "yellow", type: .prefered)
    let vegan = Dietaries(name: "Vegan", color: "red", type: .prefered)
    
    return Meal(.regular, dietaries: [noFish, vegan])
}

func makeMealWithDietaries_noRawOnion_noMeat() -> Meal {
    let noRawOnion = Dietaries(name: "No raw Onion", color: "yellow", type: .prefered)
    let noMeat = Dietaries(name: "No Meat", color: "red", type: .prefered)
    
    return Meal(.regular, dietaries: [noRawOnion, noMeat])
}

func makeMealWithDietaries_noRawOnion_vegan() -> Meal {
    let noRawOnion = Dietaries(name: "No raw Onion", color: "yellow", type: .prefered)
    let vegan = Dietaries(name: "Vegan", color: "red", type: .prefered)
    
    return Meal(.regular, dietaries: [noRawOnion, vegan])
}

func makeMealWithoutDietaries() -> Meal {
    return Meal(.regular, dietaries: [])
}

func makeDistributionManager() -> DistributionManager {
    let modelController = DistributionManager()

    let schools = [School("school one"), School("school two")]

    for school in schools {
        let classrooms = [makeClassroom(), makeClassroom(), makeClassroom(), makeClassroom(), makeClassroom()]

        for classroom in classrooms {
            let meals = [makeMealWithDietaries_noFish_vegan(), makeMealWithDietaries_noFish_vegan(), makeMealWithDietaries_noRawOnion_noMeat(), makeMealWithDietaries_noRawOnion_noMeat(), makeMealWithoutDietaries()]

            for meal in meals {
                addMeal(meal, to: classroom)
            }
            addClassroom(classroom, to: school)
        }
    }

    modelController.schools = schools
    
    return modelController
}
