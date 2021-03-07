//
//  DistributionManager.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

protocol DistributionProtocol {
    
    var schools: [School]  { get }
    
    var classroomCount: Int { get }
    
    var mealCount: Int { get }
    
    var allMeals: [Meal] { get }
    
    func countMealsContaining(_ dietary: [Dietaries]) -> Int
    
    func countMealsMatching(_ dietary: [Dietaries]) -> Int
}

extension DistributionProtocol{
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
    
    func countMealsContaining(_ dietary: [Dietaries]) -> Int {
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
    
    func countMealsMatching(_ dietary: [Dietaries]) -> Int {
        let mealsContainingDietary = allMeals.filter { (meal) -> Bool in
            if meal.dietaries.count != dietary.count { return false }
            for mealDietaries in meal.dietaries {
                if !dietary.contains(where: { $0.name == mealDietaries.name }) {
                    return false
                }
            }
            return true
        }
        return mealsContainingDietary.count
    }
}

final class DistributionManager: DistributionProtocol {
    internal var reportDelegate: ReportDelegate?
    internal var schools: [School] = []
}

extension DistributionManager {
    func packageOrder(in packagingType: [PackagingType]) -> [Packaging] {
        return schools.reduce([Packaging]()) { (packaging, school) -> [Packaging] in
            packaging + school.packMeals(with: packagingType)
        }
    }
}
