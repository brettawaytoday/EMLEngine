//
//  ReportManager.swift
//  EMLEngine
//
//  Created by Brett Christian on 3/03/21.
//

import Foundation

protocol Report {
    var type: ReportType { get }
    var title: String { get }
    var subReports: [Report] { get set }
}

protocol ReportDelegate {
    func generateReports(_ types: [ReportType], for schools: [School]) -> Report?
}

class ReportManager {
    var schools: [School] = []
}

extension ReportManager: ReportDelegate {
    func generateReports(_ types: [ReportType], for schools: [School]) -> Report? {
        self.schools = schools
        
        var report = ReportGenerator()
        
        types.forEach { (type) in
            switch type {
            case .school:
                schools.forEach {report.subReports.append(SchoolReport(title: $0.name, subReports: []))}
            case .packaging:
                report.subReports.append(PackagingReport(title: "Packaging Report", subReports: []))
            case .general:
                print("")
            }
        }
        
        return report
    }
}

extension ReportManager: DistributionProtocol {}

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
