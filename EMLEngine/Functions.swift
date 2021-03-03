//
//  Functions.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

func addClassroom(_ classroom: Classroom, to school: School) {
    var school = school
    classroom.assign(school)
    school.add(classroom)
}

func addMeal(_ meal: Meal, to classroom: Classroom){
    meal.assign(classroom)
    classroom.add(meal)
}
