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
// removed previous variables, as they would be covered in the variable tasks
    var tasks: [StudyTask]
}

// to represent a single task for a given course
struct StudyTask: Identifiable, Hashable {
    var id = UUID()
    var description: String
    var isCompleted: Bool
}

struct DataModel {
    var Courses: [Study]
}

// update testStudy, according to changes in new struct StudyTask
var testStudy = [
    Study(courseCode: "3032ICT", courseName: "Big Data Analytics and Social Media", tasks: [
        StudyTask(description: "Complete quiz", isCompleted: false),
        StudyTask(description: "Read chapter 1", isCompleted: true)
    ]),
    Study(courseCode: "3705ICT", courseName: "Virtual and Augmented Reality", tasks: [
        StudyTask(description: "Read chapter 3", isCompleted: false),
        StudyTask(description: "Complete assignment", isCompleted: false)
    ]),
    Study(courseCode: "3701ICT" , courseName: "Mobile Application Development", tasks: [
        StudyTask(description: "Create prototype", isCompleted: true),
        StudyTask(description: "Study for exam", isCompleted: false)
    ])
]


extension Study {
    var course: String {
        return "\(courseCode) \(courseName)"
    }
}
