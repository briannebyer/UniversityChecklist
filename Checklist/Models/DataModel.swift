//
//  DataModel.swift
//  Checklist
//
//  Created by Brianne Byer on 23/3/2023.
//

import Foundation

/**
 This struct represents a course, it contains information about the course code, course name and study tasks associated to the course.
 
 Parameters:
 - id: generated upon initialisation, is the UUID for the specific course.
 - courseCode: string representing the code of the course.
 - courseName: string representing the name of the course.
 - tasks: an array/list of StudyTask objects, representing study tasks associated to the course.
 */
// added codeable in order to encode and decode JSON file
struct Study: Identifiable, Hashable, Codable {
    var id = UUID()
    var courseCode: String
    var courseName: String
// removed previous variables, as they would be covered in the variable tasks
    var tasks: [StudyTask]
}

 /**
  This struct represents a task, it contains information about the task description, and whether the task has been completed.
  
  Parameters:
  - id: generated upon initialisation, is the UUID for the specific task.
  - description: string representing the what the task description.
  - isCompleted: bool representing whether task is completed (true) or incomplete (false).
  */
// added codeable in order to encode and decode JSON file
struct StudyTask: Identifiable, Hashable, Codable {
    var id = UUID()
    var description: String
    var isCompleted: Bool
}

// func
func getFile() -> URL? {
    let fileName = "UniCoursesAndTasks.json"
    let fm = FileManager.default
    guard let url = fm.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        .first else {
        return nil
        }
    return url.appendingPathComponent(fileName)
}
    
/**
 This struct represents the data model for the application.
 
 Parameters:
 - Courses: an array of 'Study' objects that represent each course.
 */
// add Codable in order to encode and decode for JSON file
struct DataModel: Codable {
    var Courses: [Study]
    init() {
        Courses = []
        load()
    }
    
// load func for JSON
    mutating func load() {
        guard let url = getFile(),
              let data = try? Data(contentsOf: url),
              let datamodel = try? JSONDecoder().decode(DataModel.self, from: data) else {
            self.Courses = testStudy
            return
        }
        self.Courses = datamodel.Courses
    }

// save func for JSON
    func save() {
        guard let url = getFile(),
              let data = try? JSONEncoder().encode(self)
        else {
            return
        }
        try? data.write(to: url)
    }
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

// An extension to the Study struct, which concenates course code and course name together, returning a string.
extension Study {
    var course: String {
        return "\(courseCode) \(courseName)"
    }
}
