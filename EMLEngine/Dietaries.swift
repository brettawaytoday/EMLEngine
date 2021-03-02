//
//  Dietaries.swift
//  EMLEngine
//
//  Created by Brett Christian on 24/02/21.
//

import Foundation

struct Dietaries {
    let name: String
    let color: String
    var type: DietaryType
    var needsCheck: Bool {
        switch type {
        case .allergy, .chokingHazard:
            return true
        default:
            return false
        }
    }
}

public enum DietaryType {
    case allergy, prefered, chokingHazard
}
