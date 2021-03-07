//
//  Meal.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

public protocol MealType {}

protocol MealProtocol {
    var classroom: Classroom? { get set }
    
    var size: MealSize { get set }
    var dietaries: [Dietaries] { get set }
    
    init(_ size: MealSize, dietaries: [Dietaries])
    
    mutating func assign(_ classroom: Classroom)
}

extension MealProtocol {
    mutating func assign(_ classroom: Classroom) {
        self.classroom = classroom
    }
}

final class Meal: MealProtocol, MealType{
    internal var classroom: Classroom?
    
    internal var size: MealSize
    internal var dietaries: [Dietaries]
    
    init(_ size: MealSize, dietaries: [Dietaries]) {
        self.size = size
        self.dietaries = dietaries
    }
}
