//
//  School.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

final class School: Reportable {
    let name: String
    var classrooms: [Classroom] = []
    
    init(_ name: String) {
        self.name = name
    }
    
    var meals: [Meal] {
        classrooms.reduce([]) { (meals, classroom) -> [Meal] in
            meals + classroom.meals
        }
    }
    
    func mealCount() -> Int{
        classrooms.reduce(0) { (result, classroom) -> Int in
            result + classroom.mealCount
        }
    }
    
    func add(_ classroom: Classroom) {
        classrooms.append(classroom)
    }
}

extension School {
    func packMeals(with packagingTypes: [PackagingType]) -> [Packaging] {
        return classrooms.reduce([Packaging]()) { (packaging, classroom) -> [Packaging] in
            packaging + classroom.packMeals(with: packagingTypes)
        }
    }
}
