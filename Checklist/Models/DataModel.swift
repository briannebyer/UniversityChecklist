//
//  DataModel.swift
//  Checklist
//
//  Created by Brianne Byer on 23/3/2023.
//

import Foundation

/**
 This struct represents a task, it contains information about the task description, and whether the task has been completed.
 
 Parameters:
 - id: generated upon initialisation, is the UUID for the specific task.
 - description: string representing the what the task description.
 - isCompleted: bool representing whether task is completed (true) or incomplete (false).
 */
// added codeable in order to encode and decode JSON file
class StudyTask: Codable, ObservableObject {
   var id = UUID()
   @Published var description: String
   @Published var isCompleted: Bool
    
    // enum
    enum CodingKeys: CodingKey {
        case description
        case isCompleted

    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
        try container.encode(isCompleted, forKey: .isCompleted)
        
    }
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        
    }
    
    init(description: String, isCompleted: Bool) {
        self.description = description
        self.isCompleted = isCompleted
       
    }
}
/**
 This struct represents a course, it contains information about the course code, course name and study tasks associated to the course.
 
 Parameters:
 - id: generated upon initialisation, is the UUID for the specific course.
 - courseCode: string representing the code of the course.
 - courseName: string representing the name of the course.
 - tasks: an array/list of StudyTask objects, representing study tasks associated to the course.
 */
// added codeable in order to encode and decode JSON file
class Study: Codable, ObservableObject {
    // do not need to publish id
    var id = UUID()
    // need to publish as they may change
    @Published var courseCode: String
    @Published var courseName: String
    @Published var tasks: [StudyTask]
    
    // enum
    enum CodingKeys: CodingKey {
        case courseCode
        case courseName
        case tasks
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(courseCode, forKey: .courseCode)
        try container.encode(courseName, forKey: .courseName)
        try container.encode(tasks, forKey: .tasks)
    }
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        courseCode = try container.decode(String.self, forKey: .courseCode)
        courseName = try container.decode(String.self, forKey: .courseName)
        tasks = try container.decode([StudyTask].self, forKey: .tasks)
    }
    
    init(courseCode: String, courseName: String, tasks:[StudyTask]) {
        self.courseCode = courseCode
        self.courseName = courseName
        self.tasks = tasks
    }
}
 
/**
 This struct represents the data model for the application.
 
 Parameters:
 - Courses: an array of 'Study' objects that represent each course.
 */
// add Codable in order to encode and decode for JSON file
class DataModel: Codable, ObservableObject {
    @Published var Courses: [Study]
    // for loading screen later
    @Published var loadingCompleted = false
    static var model: DataModel?
    
    enum CodingKeys: CodingKey {
        case Courses
    }
    
    private init() {
        Courses = []
        loadSystem()
    }
    
    static func getDataModel()->DataModel {
        guard let currentInstance = DataModel.model else {
            let newInstance = DataModel()
            DataModel.model = newInstance
            return newInstance
        }
        return currentInstance
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Courses, forKey: .Courses)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Courses = try container.decode([Study].self, forKey: .Courses)
    }
    
    func getFile()->URL? {
        let fileName = "UniCoursesAndTasks.json"
        let fm = FileManager.default
        guard let url = fm.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
            .first else {
            return nil
            }
        return url.appendingPathComponent(fileName)
        
    }
    
    // save func for JSON
        func save() {
            do{
                guard let url = getFile() else { return }
                let data = try JSONEncoder().encode(self)
                try data.write(to: url)
            } catch {
                print("save failed with error: \(error)")
            }
        }
    
    
    // loading screen?
    private func asyLoad() async ->DataModel? {
        do{
            guard let url = getFile() else { return nil }
            let datastr = try Data(contentsOf: url)
            let data = try JSONDecoder().decode(DataModel.self, from: datastr)
            return data
        }
        catch {
            print("load failed with error: \(error)")
        }
        return nil
    }
    
    // loading screen + load normal file
    func loadSystem() {
        Task {
            guard let data = await asyLoad() else {return}
            try? await Task.sleep(nanoseconds: 1000_000_000)
            DispatchQueue.main.async {
                self.Courses = data.Courses
                self.loadingCompleted = true
            }
        }
    }
}

// func save
func saveData() {
    let model = DataModel.getDataModel()
    model.save()
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

