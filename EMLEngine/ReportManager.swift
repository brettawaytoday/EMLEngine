//
//  ReportManager.swift
//  EMLEngine
//
//  Created by Brett Christian on 3/03/21.
//

import Foundation

public protocol Report {
    var type: ReportType { get set }
    var title: String { get set }
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
    func generateReports(for schools: [School]) -> Report?
}

class ReportManager {
    var schools: [School] = []
}

extension ReportManager: ReportDelegate {
    func generateReports(for schools: [School]) -> Report? {
        self.schools = schools
        
        var report = ReportGenerator()
        report.subReports.append(contentsOf: schoolReports())
        report.subReports.append(PackagingReport(title: "Packaging Report", subReports: []))
        
        
        return report
    }
    
    private func schoolReports() -> [Report] {
        schools.map { school in
            SchoolReport(school: school, with: classroomReports(for: school))
        }
    }
    
    private func classroomReports(for school: School) -> [Report] {
        school.classrooms.map { classroom in
            ClassroomReport(classroom: classroom, with: mealReports(for: classroom))
        }
    }
    
    private func mealReports(for classroom: Classroom) -> [Report] {
        classroom.meals.map { meal in
            MealReport(meal: meal)
        }
    }
}

extension ReportManager: DistributionProtocol {}

extension DistributionManager {
    func requestReports() -> Report? {
        return reportDelegate?.generateReports(for: schools)
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
    
    init(school: School, with classrooms: [Report]) {
        self.title = school.name
        self.subReports = classrooms
    }
    
    var classrooms: [Report] {
        return subReports.filter { $0.type == .classroom }
    }
}

struct ClassroomReport: Report {
    var type: ReportType = .classroom
    var title: String
    var subReports: [Report]
    
    init(classroom: Classroom, with meals: [Report]) {
        self.title = classroom.name
        self.subReports = meals
    }
    
    var meals: [Report] {
        subReports.filter { $0.type == .meal }
    }
}

struct MealReport: Report {
    var type: ReportType = .meal
    var title: String
    var subReports: [Report]
    
    init(meal: Meal) {
        self.title = meal.description
        self.subReports = []
    }
}

struct PackagingReport: Report {
    var type: ReportType = .packaging
    var title: String
    var subReports: [Report]
}
