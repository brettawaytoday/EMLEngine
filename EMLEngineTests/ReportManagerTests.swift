//
//  ReportManagerTests.swift
//  EMLEngineTests
//
//  Created by Brett Christian on 3/03/21.
//

import Foundation
import XCTest
@testable import EMLEngine

class ReportManagerTests: XCTestCase {
    
    func test_distributionManagerDelegate_isNotNil() {
        XCTAssertNotNil(makeSut().distributionManager.reportDelegate)
    }
    
    func test_reportManager_generatesReport() {
        XCTAssertNotNil(makeSut().distributionManager.requestReports())
    }
    
    func test_reportManager_generatesReport_withTwoSubreports() {
        let sut = makeSut()
        sut.distributionManager.schools = [makeSchool()]
        XCTAssertEqual(sut.distributionManager.requestReports()?.subReports.count, 2)
    }
    
    //MARK: - Helpers
    
    private func makeSut() -> Builder {
        return Builder()
    }
}


fileprivate class Builder {
    let distributionManager: DistributionManager
    let reportManager: ReportManager
    
    init() {
        self.distributionManager = DistributionManager()
        self.reportManager = ReportManager()
        self.distributionManager.reportDelegate = reportManager
    }
}
