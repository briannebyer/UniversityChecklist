//
//  DataModel.swift
//  Checklist
//
//  Created by Brianne Byer on 23/3/2023.
//

import Foundation

/**
 This class represents a task, it contains information about the task description, and whether the task has been completed.
 
 - Parameter id: generated upon initialisation, is the UUID for the specific task.
 - Parameter description: string representing the what the task description.
 - Parameter isCompleted: bool representing whether task is completed (true) or incomplete (false).
 
 - Important: This class conforms to the Codable and ObservableObject protocols, and can be used with @ObservedObject and @Published property wrappers.
 
 */
class StudyTask: Codable, ObservableObject {
   var id = UUID()
   @Published var description: String
   @Published var isCompleted: Bool
    
    /**
     This enum represents the coding keys used for encoding and decoding instances of StudyTask.
     
     - 'description': key used to encode and decode the description property
     - 'isCompleted': key used to encode and decode the isCompleted property
     
     */
    enum CodingKeys: CodingKey {
        case description
        case isCompleted

    }
    /**
     This function encodes the StudyTask instance to JSON format using the encoder parameter.
     
     - Parameter encoder: encoder that will be used to encode the StudyTask instance to JSON format.
     - Throws: 'EncodingError.invalid Value' if the description or isCompleted properties of StudyTask instance fail to be encoded.
     - Remark: function is required to conform to the Encodable protocol.
     - SeeAlso: init(from:) for decoding JSON data
    
     */
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
        try container.encode(isCompleted, forKey: .isCompleted)
        
    }
    /**
     This function decodes the StudyTask instance to JSON format using the decoder parameter.
     
     - Parameter decoder: encoder that will be used to encode the StudyTask instance to JSON format.
     - Throws: 'DecodingError.invalid Value' if the description or isCompleted properties of StudyTask instance fail to be decoded.
     - Remark: function is required to conform to the Decodable protocol.
     - SeeAlso: encode(to:) for encoding JSON data
    
     */
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        
    }
    /**
    Initialises a new StudyTask instance with the provided description and completion status.

    - Parameter description: The description of the new task.
    - Parameter isCompleted: The completion status of the new task. If true, the task is completed, otherwise, the task is incomplete.
     
    */
    init(description: String, isCompleted: Bool) {
        self.description = description
        self.isCompleted = isCompleted
       
    }
}

/**
 This class represents a course and contains information about the course code, course name, and study tasks associated with the course.

 - Parameter id: generated upon initialisation, is the UUID for the specific course.
 - Parameter courseCode: string representing the code of the course.
 - Parameter courseName: string representing the name of the course.
 - Parameter tasks: an array of StudyTask objects, representing study tasks associated to the course.
 
 - Remark:class conforms to the Codable protocol to allow for encoding and decoding of JSON files.
 - Important: id property is generated automatically and does not need to be published. The courseCode, courseName, and tasks properties are marked with @Published as they may change.
 - Requires: courseCode and courseName should not be empty strings.
 
*/
class Study: Codable, ObservableObject {
    // do not need to publish id
    var id = UUID()
    // need to publish as they may change
    @Published var courseCode: String
    @Published var courseName: String
    @Published var tasks: [StudyTask]
    
    /**
    This enum defines the coding keys used for encoding and decoding instances of Study..

    'courseCode': coding key used to encode and decode the courseCode property.
    'courseName': coding key used to encode and decode the courseName property.
    'tasks': coding key used to encode and decode the tasks property.
    */
    enum CodingKeys: CodingKey {
        case courseCode
        case courseName
        case tasks
    }
    /**
     This function encodes the Study instance to JSON format using the encoder parameter.
     
     - Parameter encoder: encoder that will be used to encode the StudyTask instance to JSON format.
     - Throws: 'EncodingError.invalid Value' if the courseCode, courseName or tasks properties of Study  instance fail to be encoded.
     - Remark: function is required to conform to the Encodable protocol.
     - SeeAlso: init(from:) for decoding JSON data
    
     */
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(courseCode, forKey: .courseCode)
        try container.encode(courseName, forKey: .courseName)
        try container.encode(tasks, forKey: .tasks)
    }
    /**
     This function decodes the Study instance to JSON format using the decoder parameter.
     
     - Parameter decoder: encoder that will be used to encode the Study instance to JSON format.
     - Throws: 'DecodingError.invalid Value' if the courseCode, courseName or tasks properties of Study  instance fail to be decoded.
     - Remark: function is required to conform to the Encodable protocol.
     - SeeAlso: encode(to:) for encoding JSON data
    
     */
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        courseCode = try container.decode(String.self, forKey: .courseCode)
        courseName = try container.decode(String.self, forKey: .courseName)
        tasks = try container.decode([StudyTask].self, forKey: .tasks)
    }
    /**
    Initialises a new Study instance with the provided course code, course name, and tasks.

    - Parameter courseCode: code of the course.
    - Parameter courseName: name of the course.
    - Parameter tasks: array of StudyTask objects representing study tasks associated with the course.

    */
    init(courseCode: String, courseName: String, tasks:[StudyTask]) {
        self.courseCode = courseCode
        self.courseName = courseName
        self.tasks = tasks
    }
}
 
/**
 This class represents the data model for the application. It manages study tasks and courses. It contains an array of Study objects, representing all the courses and associated study tasks. Additionally, it has a loadingCompleted property that tracks whether the data model has finished loading data. Finally, it has a model static property that can be used to access a shared instance of the data model.

 - Parameter Courses: array of Study objects representing all the courses and associated study tasks.
 - Parameter loadingCompleted: boolean indicating whether the data model has finished loading data from an external source.
 - Parameter model: static property that can be used to access a shared instance of the data model.
 
 - Important: This class conforms to the Codable and ObservableObject protocols, and can be used with @ObservedObject and @Published property wrappers.
 
 */
class DataModel: Codable, ObservableObject {
    @Published var Courses: [Study]
    // for loading screen later
    @Published var loadingCompleted = false
    static var model: DataModel?
    
    /**
        This enum represents the coding keys used for encoding and decoding instances of DataModel.
     
        - 'Courses': key used to encode and decode the Courses property.
        
        */
    enum CodingKeys: CodingKey {
        case Courses
    }
    /**
      Initialises an empty Courses array and  loads the system state.
        */
    private init() {
        Courses = []
        loadSystem()
    }
    /**
    Returns the current DataModel instance, creating it if it does not exist.
    - Returns: current DataModel instance.
    */
    static func getDataModel()->DataModel {
        guard let currentInstance = DataModel.model else {
            let newInstance = DataModel()
            DataModel.model = newInstance
            return newInstance
        }
        return currentInstance
    }
    /**
     This function encodes the DataModel instance to JSON format using the encoder parameter.
     
     - Parameter encoder: encoder that will be used to encode the DataModel instance to JSON format.
     - Throws: 'EncodingError.invalidValue'  if the Courses property fails to be encoded.
     - Remark: function is required to conform to the Encodable protocol.
     - SeeAlso: init(from:) for decoding JSON data.
     
     */
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Courses, forKey: .Courses)
    }
    /**
     This function decodes the DataModel instance from JSON format using the decoder parameter.
     
     - Parameter decoder: decoder that will be used to decode the DataModel instance from JSON format.
     - Throws: 'DecodingError.invalidValue' if the Courses property of the DataModel instance fails to be decoded.
     - Remark: function is required to conform to the Decodable protocol.
     - SeeAlso: encode(to:) for encoding JSON data
     
     */
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Courses = try container.decode([Study].self, forKey: .Courses)
    }
    
    /**
     This function returns a URL pointing to the 'UniCourses AndTasks.json' file in the application's document directory. It will be used to read and write data, to and from the file.
     
     - Returns: URL pointing to JSON file, or nil.
     */
    func getFile()->URL? {
        let fileName = "UniCoursesAndTasks.json"
        let fm = FileManager.default
        guard let url = fm.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
            .first else {
            return nil
            }
        return url.appendingPathComponent(fileName)
        
    }
    
    /**
     This function saves current state of DataModel instance by encoding it to JSON format and writing it to 'UniCourses AndTasks.json' file.
     
     - Throws: prints error message to console if encoding or writing fails.
     - SeeAlso: getFile() for getting URL of file to be written.
     
     */
        func save() {
            do{
                guard let url = getFile() else { return }
                let data = try JSONEncoder().encode(self)
                try data.write(to: url)
            } catch {
                print("save failed with error: \(error)")
            }
        }
    /**
     This asynchronous function loads the saved state of a DataModel instance by decoding it from the 'UniCoursesAndTasks.json' file.

     - Returns: decoded DataModel instance, or nil if there was an error.
     - Throws: prints an error message to console if decoding fails.
     - SeeAlso: getFile() for getting the URL of the file to be read.
     
     */
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
    /**
     This function displays a loading screen and loads the saved state of DataModel instance from 'UniCoursesAndTasks.json'. This is completed in the background by using the asyLoad() function. When loading is complete, it updates the Courses property of the DataModel instance, setting the loadedCompleted property to true.
     
     - Remark: function is required to conform to Encodable protocol.
     - SeeAlso: asyLoad() for loading saved state of DataModel instance in background, using async/await.
     */
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

/**
This function saves the current state of the single instance of DataModel by calling its save() method.
*/
func saveData() {
    let model = DataModel.getDataModel()
    model.save()
}

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


