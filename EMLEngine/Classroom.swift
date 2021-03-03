//
//  Classroom.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

protocol ClassroomProtocol {
    var school: School? { get set }
    var name: String { get }
    
    var meals: [Meal] { get set }
    
    init(_ name: String)
    
    var mealCount: Int { get }
    
    mutating func assign(_ school: School)
    
    mutating func add(_ meal: Meal)
}

extension ClassroomProtocol {
    var mealCount: Int {
        meals.count
    }
    
    mutating func assign(_ school: School) {
        self.school = school
    }
    
    mutating func add(_ meal: Meal) {
        meals.append(meal)
    }
}

final class Classroom: ClassroomProtocol {
    internal var school: School?
    internal var name: String
    
    internal var meals: [Meal] = []
    
    init(_ name: String) {
        self.name = name
    }
}
