//
//  DataManager.swift
//  EMLEngine
//
//  Created by Brett Christian on 18/03/21.
//

import Foundation

public class DataManager {
    let distributionManager: DistributionManager
    
    init(_ distributionManager: DistributionManager){
        self.distributionManager = distributionManager
    }
    
    public func getSchools() -> [School] {
        return distributionManager.schools
    }
    
    public func getClassrooms() -> [Classroom] {
        return distributionManager.allClassrooms
    }
    
    public func getMeals() -> [Meal] {
        return distributionManager.allMeals
    }
    
    public func getPackaging() -> [Packaging] {
        return distributionManager.packageOrder(in: [.boxSix, .boxTwelve])
    }
    
    public func getReport() -> Report? {
        return distributionManager.requestReports(packagingType: [.boxSix, .boxTwelve])
    }
}

