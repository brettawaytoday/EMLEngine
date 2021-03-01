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

public func makePackaging(_ packagingType: PackagingType) -> Packaging {
    switch packagingType {
    case .boxSix:
        return Box(.boxSix, 6)
    case .boxTwelve:
        return Box(.boxTwelve, 12)
    }
}

struct Box: Packaging {
    internal var packagingType: PackagingType
    
    internal var capacity: Int
    internal var meals: [MealType] = []
    
    init(_ packagingType: PackagingType, _ capacity: Int) {
        self.packagingType = packagingType
        self.capacity = capacity
    }
}
