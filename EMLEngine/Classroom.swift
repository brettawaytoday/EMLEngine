//
//  Classroom.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

final class Classroom {
    var school: School?
    let name: String
    
    var meals: [Meal] = []
    
    
    var mealCount: Int {
        meals.count
    }
    
    init(_ name: String) {
        self.name = name
    }
    
    func assign(_ school: School) {
        self.school = school
    }
    
    func add(_ meal: Meal) {
        meals.append(meal)
    }
}
