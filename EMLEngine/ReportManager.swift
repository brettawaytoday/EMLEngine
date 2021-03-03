//
//  ReportManager.swift
//  EMLEngine
//
//  Created by Brett Christian on 3/03/21.
//

import Foundation

protocol Reportable {
    var name: String { get }
}

protocol Report {
    var type: ReportType { get }
    var title: String { get }
    var subReports: [Report] { get set }
}

protocol ReportDelegate {
    func generateReports(_ types: [ReportType], for items: [Reportable]) -> Report?
}

class ReportManager: ReportDelegate {
    var report: Report?
    
    func generateReports(_ types: [ReportType], for items: [Reportable]) -> Report? {
        var newReport = ReportGenerator()
        
        types.forEach { (type) in
            switch type {
            case .school:
                items.forEach {newReport.subReports.append(SchoolReport(title: $0.name, subReports: []))}
            case .packaging:
                newReport.subReports.append(PackagingReport(title: "Packaging Report", subReports: []))
            case .general:
                print("")
            }
        }
        
        return newReport
    }
}

extension DistributionManager {
    func requestReports(types: [ReportType]) -> Report? {
        return reportDelegate?.generateReports(types, for: schools)
    }
}

public enum ReportType {
    case school, packaging, general
}

struct ReportGenerator: Report {
    var type: ReportType = .general
    var title: String = "Report"
    var subReports: [Report] = []
}

struct SchoolReport: Report {
    var type: ReportType = .school
    var title: String
    var subReports: [Report]
}

struct PackagingReport: Report {
    var type: ReportType = .packaging
    var title: String
    var subReports: [Report]
}
