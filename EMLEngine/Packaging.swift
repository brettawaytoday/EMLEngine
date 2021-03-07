//
//  Packaging.swift
//  EMLEngine
//
//  Created by Brett Christian on 2/03/21.
//

import Foundation

public enum PackagingType {
    case boxTwelve, boxSix
}

public protocol Packaging {
    var packagingType: PackagingType { get }
    var capacity: Int { get }
    var meals: [MealType] { get set }
}

public protocol PackagingUse {
    func packMeals(with packageTypes: [PackagingType]) -> [Packaging]
}


/// Public function to build packaging of the types required.
/// - Parameter packagingType: Describes the type of container and how many meals it can accommodate.
/// - Returns: A container of type Packaging with a capacity.
public func makePackaging(_ packagingType: PackagingType) -> Packaging {
    switch packagingType {
    case .boxSix:
        return Box(.boxSix, 6)
    case .boxTwelve:
        return Box(.boxTwelve, 12)
    }
}


/// Packaging in the form of a box to pack meals into. It has a meal capacity and accepts a meal type.
struct Box: Packaging {
    internal var packagingType: PackagingType
    
    internal var capacity: Int
    internal var meals: [MealType] = []
    
    init(_ packagingType: PackagingType, _ capacity: Int) {
        self.packagingType = packagingType
        self.capacity = capacity
    }
}
