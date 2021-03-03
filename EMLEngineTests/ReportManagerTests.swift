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
    
    func test_orderReturnsReport() {
        let report = ReportGenerator(title: "Report Title")
        let reportManager = ReportManager()
        reportManager.report = report
        
        XCTAssertEqual(reportManager.report?.title, "Report Title")
    }
    
    func test_distributionManagerDelegate_isNotNil() {
        let distributionManager = DistributionManager()
        let reportManager = ReportManager()
        distributionManager.reportDelegate = reportManager
        XCTAssertNotNil(distributionManager.reportDelegate)
    }
    
    func test_reportManager_generatesReport() {
        let distributionManager = DistributionManager()
        let reportManager = ReportManager()
        distributionManager.reportDelegate = reportManager
        
        XCTAssertNotNil(distributionManager.requestReports(types: [.general]))
    }
    
    func test_reportManager_generatesReport_withTwoSubreports() {
        let distributionManager = DistributionManager()
        distributionManager.schools = [makeSchool()]
        let reportManager = ReportManager()
        distributionManager.reportDelegate = reportManager
        
        XCTAssertEqual(distributionManager.requestReports(types: [.school, .packaging])?.subReports.count, 2)
    }
}
