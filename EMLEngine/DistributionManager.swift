//
//  DistributionManager.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

class DistributionManager {
    var schools: [School] = []
    
    var classroomCount: Int {
        schools.reduce(0) { (result, school) -> Int in
            result + school.classrooms.count
        }
    }
    
    var mealCount: Int {
        schools.reduce(0) { (result, school) -> Int in
            result + school.mealCount()
        }
    }
    
    var allMeals: [Meal] {
        schools.reduce([]) { (meals, school) -> [Meal] in
            meals + school.meals
        }
    }
    
    func countMealsWith(_ dietary: [Dietaries]) -> Int {
        let mealsContainingDietary = allMeals.filter { (meal) -> Bool in
            var containsDietary = false
            for mealDietaries in meal.dietaries {
                if dietary.contains(where: { $0.name == mealDietaries.name }) {
                    containsDietary = true
                }
            }
            return containsDietary
        }
        return mealsContainingDietary.count
    }
}
