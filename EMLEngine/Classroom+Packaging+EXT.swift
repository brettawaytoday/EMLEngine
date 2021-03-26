//
//  Classroom+Packaging+EXT.swift
//  EMLEngine
//
//  Created by Brett Christian on 2/03/21.
//

import Foundation

#warning("This method is not packing the boxes correctly.")
extension Classroom: PackagingUse {
    public func packMeals(with packageTypes: [PackagingType]) -> [Packaging] {
        var allMeals = meals
        var packaging: [Packaging] = []

        var availablePackaging: [Packaging] = []
        for packagingType in packageTypes {
            availablePackaging.append(makePackaging(packagingType))
        }
        availablePackaging = availablePackaging.sorted { $0.capacity > $1.capacity }
        
        while allMeals.count > 0 {
            for (index, availableContainer) in availablePackaging.enumerated() {
                    if allMeals.count >= availableContainer.capacity {
                        while allMeals.count >= availableContainer.capacity {
                            var container = makePackaging(availableContainer.packagingType)
                            while container.meals.count < container.capacity {
                                container.meals.append(allMeals.remove(at: 0))
                            }
                            packaging.append(container)
                        }
                    } else {
                        if availablePackaging.count < index + 1 {
                            let nextPackaging = availablePackaging[index + 1]
                            if allMeals.count <= nextPackaging.capacity {
                                while allMeals.count >= nextPackaging.capacity {
                                    var container = makePackaging(nextPackaging.packagingType)
                                    while container.meals.count < container.capacity {
                                        container.meals.append(allMeals.remove(at: 0))
                                    }
                                    packaging.append(container)
                                }
                            }
                        }
                    }
                
                
            }
            if allMeals.count > 0 {
                guard let smallestContainer = availablePackaging.last else { return [] }
                    var container = makePackaging(smallestContainer.packagingType)
                    while container.meals.count < container.capacity && allMeals.count > 0 {
                        container.meals.append(allMeals.remove(at: 0))
                    }
                    packaging.append(container)
            }
        }
        return packaging
    }
}
