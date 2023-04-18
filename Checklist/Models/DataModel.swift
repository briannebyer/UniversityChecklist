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
class Study: Identifiable, Hashable, Codable {
    var id = UUID()
    var courseCode: String
    var courseName: String
// removed previous variables, as they would be covered in the variable tasks
    var tasks: [StudyTask]
    
    // allows creation of new instance of Study
    init(courseCode: String, courseName: String, tasks: [StudyTask]) {
        self.courseCode = courseCode
        self.courseName = courseName
        self.tasks = tasks
    }
    
    // Equatable conformance
    static func == (lhs: Study, rhs: Study) -> Bool {
        return lhs.id == rhs.id &&
        lhs.courseCode == rhs.courseCode &&
        lhs.courseCode == rhs.courseName &&
        lhs.tasks == rhs.tasks
    }
    // Hashable conformance
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(courseCode)
        hasher.combine(courseName)
        hasher.combine(tasks)
    }

}

 /**
  This struct represents a task, it contains information about the task description, and whether the task has been completed.
  
  Parameters:
  - id: generated upon initialisation, is the UUID for the specific task.
  - description: string representing the what the task description.
  - isCompleted: bool representing whether task is completed (true) or incomplete (false).
  */
// added codeable in order to encode and decode JSON file
class StudyTask: Identifiable, Hashable, Codable {
    var id = UUID()
    var description: String
    var isCompleted: Bool
    
    // allows creation of new instance
    init(description: String, isCompleted: Bool){
        self.description = description
        self.isCompleted = isCompleted
    }
    
    // Equatable conformance
    static func == (lhs: StudyTask, rhs: StudyTask) -> Bool {
        return lhs.id == rhs.id &&
        lhs.description == rhs.description &&
        lhs.isCompleted == rhs.isCompleted
    }
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(description)
        hasher.combine(isCompleted)
    }
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
// add Observable object
class DataModel: Codable, ObservableObject {
    var courses: [Study]
    
  //
    init(courses: [Study]){
        self.courses = courses
        
        // load data here?
        // DataModel.load()
    }
    
    //
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        courses = try container.decode([Study].self, forKey: .courses)
    }
    
    //
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(courses, forKey: .courses)
    }
    
    //
    enum CodingKeys: String, CodingKey {
        case courses
    }
    
// load func for JSON
     class func load() -> DataModel {
        guard let url = getFile(),
              let data = try? Data(contentsOf: url),
              let datamodel = try? JSONDecoder().decode(DataModel.self, from: data) else {
            // use testStudy data if unable to get JSON file data
            return DataModel(courses: testStudy)
        }
        return datamodel
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
