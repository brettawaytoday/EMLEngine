//
//  Meal.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

public protocol MealType {}

final class Meal: MealType{
    var classroom: Classroom?
    
    let size: MealSize
    var dietaries: [Dietaries]
    
    init(_ size: MealSize, dietaries: [Dietaries]) {
        self.size = size
        self.dietaries = dietaries
    }
    
    func assign(_ classroom: Classroom) {
        self.classroom = classroom
    }
}
