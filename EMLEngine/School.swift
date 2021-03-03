//
//  School.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

protocol SchoolProtocol {
    var name: String { get }
    var classrooms: [Classroom] { get set }
    var meals: [Meal] { get }
    
    func mealCount() -> Int
    mutating func add(_ classroom: Classroom)
    
    init(_ name: String)
}

extension SchoolProtocol {
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
    
    mutating func add(_ classroom: Classroom) {
        classrooms.append(classroom)
    }
}

final class School: SchoolProtocol, Reportable {
    internal var name: String
    internal var classrooms: [Classroom] = []
    
    init(_ name: String) {
        self.name = name
    }
}

extension School {
    func packMeals(with packagingTypes: [PackagingType]) -> [Packaging] {
        return classrooms.reduce([Packaging]()) { (packaging, classroom) -> [Packaging] in
            packaging + classroom.packMeals(with: packagingTypes)
        }
    }
}
