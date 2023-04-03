//
//  DataModel.swift
//  Checklist
//
//  Created by Brianne Byer on 23/3/2023.
//

import Foundation

struct Study: Identifiable, Hashable {
    var id = UUID()
    var courseCode: String
    var courseName: String
    var task: String
    var checkbox: String
}

struct DataModel {
    var Courses: [Study]
}

var testStudy = [
    Study(courseCode: "3032ICT", courseName: "Big Data Analytics and Social Media", task: "Complete quiz", checkbox: "checkmark.square"),
    Study(courseCode: "3705ICT", courseName: "Virtual and Augmented Reality", task: "Read chapter", checkbox: "checkmark.square.fill"),
    Study(courseCode: "3701ICT" , courseName: "Mobile Application Development", task: "Create prototype", checkbox: "checkmark.square")
]

extension Study {
    var course: String {
        return "\(courseCode) \(courseName)"
    }
}
