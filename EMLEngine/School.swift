//
//  School.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

class School {
    let name: String
    var classrooms: [Classroom] = []
    
    init(_ name: String) {
        self.name = name
    }
    
    func add(_ classroom: Classroom) {
        classrooms.append(classroom)
    }
}

class Classroom {
    var school: School?
    let name: String
    
    var meals: [Meal] = []
    
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



class Meal {
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

enum MealSize {
    case regular
    case hungry
}

struct Dietaries {
    let name: String
    let color: String
}


func addClassroom(_ classroom: Classroom, to school: School) {
    classroom.assign(school)
    school.add(classroom)
}

func addMeal(_ meal: Meal, to classroom: Classroom){
    meal.assign(classroom)
    classroom.add(meal)
}
