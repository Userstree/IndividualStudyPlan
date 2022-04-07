//
//  Plan.swift
//  IndividualStudyPlan
//
//  Created by Dossymkhan Zhulamanov on 06.04.2022.
//

import Foundation

struct Plan: Hashable, Codable  {
    var Title: String
    var IUPSid: String
    var DocumentURL: String
    var AcademicYear: String
    var AcademicYearId: String
    var Semesters: [Semester]
}

struct Semester: Hashable, Codable {
    var Number: String
    var Disciplines: [Discipline]
}

struct Discipline: Hashable, Identifiable, Codable {
    var id: String { DisciplineId }
    
    var DisciplineId: String
    var DisciplineName: DisciplineName
    var Lesson: [Lesson]
}

struct DisciplineName: Hashable, Codable {
    var nameKk: String
    var nameRu: String
    var nameEn: String
}

struct Lesson: Hashable, Codable {
    var LessonTypeId: String
    var Hours: String
    var RealHours: String
}
