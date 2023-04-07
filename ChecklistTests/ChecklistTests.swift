//
//  ChecklistTests.swift
//  ChecklistTests
//
//  Created by Brianne Byer on 15/3/2023.
//

import XCTest
@testable import Checklist

class ChecklistTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /**
     This function tests that the courseCode property is correctly set for each Study object in the testStudy array.
     
     Assert that the courseCode property of the first, second, and third Study objects in the testStudy array, are equal to the expected values.
     */
    func testCourseCode() throws {
        XCTAssertEqual(testStudy[0].courseCode, "3032ICT")
        XCTAssertEqual(testStudy[1].courseCode, "3705ICT")
        XCTAssertEqual(testStudy[2].courseCode, "3701ICT")
    }
    
    /**
     This function tests that the courseName property is correctly set for each Study object in the testStudy array.
     
     Assert that the courseName property of the first, second, and third Study objects in the testStudy array, are equal to the expected values.
     */
    func testCourseName() throws {
        XCTAssertEqual(testStudy[0].courseName, "Big Data Analytics and Social Media")
        XCTAssertEqual(testStudy[1].courseName, "Virtual and Augmented Reality")
        XCTAssertEqual(testStudy[2].courseName, "Mobile Application Development")
    }
    
    /**
     This function tests that the number of tasks in the StudyTasks array is correct for each Study object in the testStudy array.
     
     Assert that the count of the StudyTasks array of the first, second, and third Study objects in the testStudy array, are equal to the expected value of 2.
     */
    func testTasksCount() throws {
        XCTAssertEqual(testStudy[0].tasks.count, 2)
        XCTAssertEqual(testStudy[1].tasks.count, 2)
        XCTAssertEqual(testStudy[2].tasks.count, 2)
    }
    
    /**
     This function tests whether the .isCompleted toggle functionality of the StudyTask struct works correctly.
     Assert that the description and isCompleted properties of the first and second StudyTask object, within the testStudy array, are equal to the expected values.
     Check that the .isCompleted toggle functionality works as expected, by performing a series of toggle operations. Assert that the isCompleted property of the relevant StudyTask object matches the expected value after each operation.
      */
    func testToggle() throws {
        
        // check whether values are set correctly
        XCTAssertEqual(testStudy[0].tasks[0].description, "Complete quiz")
        XCTAssertFalse(testStudy[0].tasks[0].isCompleted)
        // check whether values are set correctly
        XCTAssertEqual(testStudy[0].tasks[1].description, "Read chapter 1")
        XCTAssertTrue(testStudy[0].tasks[1].isCompleted)
        
        // check toggle functionality, should be True
        testStudy[0].tasks[0].isCompleted.toggle()
        XCTAssertTrue(testStudy[0].tasks[0].isCompleted)
        // check toggle functionality, should be False
        testStudy[0].tasks[0].isCompleted.toggle()
        XCTAssertFalse(testStudy[0].tasks[0].isCompleted)
        
        
        // check toggle functionality, should be False
        testStudy[0].tasks[0].isCompleted.toggle()
        XCTAssertFalse(testStudy[0].tasks[0].isCompleted)
        // check toggle functionality, should be True
        testStudy[0].tasks[0].isCompleted.toggle()
        XCTAssertTrue(testStudy[0].tasks[0].isCompleted)

    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
