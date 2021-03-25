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

public final class Meal: MealProtocol, MealType {
    internal var classroom: Classroom?
    
    public var size: MealSize
    public var dietaries: [Dietaries]
    
    init(_ size: MealSize, dietaries: [Dietaries]) {
        self.size = size
        self.dietaries = dietaries
    }
    
    public var description: String {
        var description = ""
        switch size {
        case .hungry:
            description = "Hungry"
        case .regular:
            description = "Regular"
        }
        
        if dietaries.count == 0 { return description }
        
        description = description + " -"
        
        for item in dietaries {
            description = description + " (" + item.name + ")"
        }
        
        
        return description
    }
}
