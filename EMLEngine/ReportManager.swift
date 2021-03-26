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
    public var packagingReports: [Report] {
        subReports.filter { $0.type == .packaging }
    }
    
    public func search(for reportType: ReportType) -> [Report] {
        let filtered: [Report] = subReports.filter { $0.type == reportType }
        return filtered
    }
}

protocol ReportDelegate {
    func generateReports(with packagingType: [PackagingType], for schools: [School]) -> Report?
}

class ReportManager {
    var schools: [School] = []
}

extension ReportManager: ReportDelegate {
    func generateReports(with packagingType: [PackagingType], for schools: [School]) -> Report? {
        self.schools = schools
        
        var report = ReportGenerator()
        
        report.subReports.append(contentsOf: schoolReports(with: packagingType))
        
        
        return report
    }
    
    private func schoolReports(with packagingType: [PackagingType]) -> [Report] {
        schools.map { school in
            var schoolReport = SchoolReport(school: school, with: classroomReports(with: packagingType, for: school))
            schoolReport.subReports.append(contentsOf: packagingReport(with: packagingType, for: school))
            return schoolReport
        }
    }
    
    private func packagingReport(with packagingType: [PackagingType], for school: School) -> [Report] {
        school.packMeals(with: packagingType).map { (packaging) -> Report in
            PackagingReport(packaging: packaging)
        }
    }
    
    private func classroomReports(with packagingType: [PackagingType], for school: School) -> [Report] {
        school.classrooms.map { classroom in
            var classroomReport = ClassroomReport(classroom: classroom, with: mealReports(for: classroom))
            classroomReport.subReports.append(contentsOf: packagingReport(with: packagingType, for: classroom))
            return classroomReport
        }
    }
    
    private func packagingReport(with packagingType: [PackagingType], for classroom: Classroom) -> [Report] {
        classroom.packMeals(with: packagingType).map { (packaging) -> Report in
            PackagingReport(packaging: packaging)
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
    func requestReports(packagingType: [PackagingType]) -> Report? {
        return reportDelegate?.generateReports(with: packagingType, for: schools)
    }
}

public enum ReportType {
    case school, classroom, meal, packaging, general
}

public struct ReportGenerator: Report {
    public var type: ReportType = .general
    public var title: String = "Report"
    public var subReports: [Report] = []
    
    public var schools: [Report] {
        subReports.filter { $0.type == .school }
    }
    
    public var classrooms: [Report] {
        schools.reduce([Report]()) { (classrooms, school) -> [Report] in
            guard let school = school as? SchoolReport else { return [] }
            return classrooms + school.classrooms
        }
    }
}

public struct SchoolReport: Report {
    public var type: ReportType = .school
    public var title: String
    public var subReports: [Report]
    
    init(school: School, with classrooms: [Report]) {
        self.title = school.name
        self.subReports = classrooms
    }
    
    public var classrooms: [Report] {
        return subReports.filter { $0.type == .classroom }
    }
}

public struct ClassroomReport: Report {
    public var type: ReportType = .classroom
    public var title: String
    public var subReports: [Report]
    
    init(classroom: Classroom, with meals: [Report]) {
        self.title = classroom.name
        self.subReports = meals
    }
    
    var meals: [Report] {
        subReports.filter { $0.type == .meal }
    }
}

public struct MealReport: Report {
    public var type: ReportType = .meal
    public var title: String
    public var subReports: [Report]
    
    public var colors: [String] = []
    
    public var chocking: Bool = false
    public var allergy: Bool = false
    
    init(meal: Meal) {
        self.title = meal.description
        self.colors = meal.colors
        self.chocking = meal.chocking
        self.allergy = meal.allergy
        self.subReports = []
    }
}

public struct PackagingReport: Report {
    public var type: ReportType = .packaging
    public var title: String
    public var details: String
    public var subReports: [Report]
    
    init(packaging: Packaging) {
        self.title = packaging.title
        self.details = packaging.details
        self.subReports = []
    }
}
