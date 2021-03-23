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
    var packagingReports: [Report] { get }
    
    func search(for reportType: ReportType) -> [Report]
}

extension Report {
    var packagingReports: [Report] {
        subReports.filter { $0.type == .packaging }
    }
    
    func search(for reportType: ReportType) -> [Report] {
        subReports.filter { $0.type == reportType }
    }
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
            case .classroom:
                print("")
            case .meal:
                print("")
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
    case school, classroom, meal, packaging, general
}

struct ReportGenerator: Report {
    var type: ReportType = .general
    var title: String = "Report"
    var subReports: [Report] = []
    
    var schools: [Report] {
        subReports.filter { $0.type == .school }
    }
}

struct SchoolReport: Report {
    var type: ReportType = .school
    var title: String
    var subReports: [Report]
    
    var classrooms: [Report] {
        return subReports.filter { $0.type == .classroom }
    }
}

struct ClassroomReport: Report {
    var type: ReportType = .classroom
    var title: String
    var subReports: [Report]
    
    var meals: [Report] {
        subReports.filter { $0.type == .meal }
    }
}

struct MealReport: Report {
    var type: ReportType = .meal
    var title: String
    var subReports: [Report]
}

struct PackagingReport: Report {
    var type: ReportType = .packaging
    var title: String
    var subReports: [Report]
}
