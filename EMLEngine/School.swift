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

func addClassroom(_ classroom: Classroom, to school: School) {
    classroom.assign(school)
    school.add(classroom)
}

func addMeal(_ meal: Meal, to classroom: Classroom){
    meal.assign(classroom)
    classroom.add(meal)
}
