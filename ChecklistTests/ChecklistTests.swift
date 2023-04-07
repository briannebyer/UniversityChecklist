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
    
    // this function checks that each course code is correct
    func testCourseCode() throws {
        XCTAssertEqual(testStudy[0].courseCode, "3032ICT")
        XCTAssertEqual(testStudy[1].courseCode, "3705ICT")
        XCTAssertEqual(testStudy[2].courseCode, "3701ICT")
    }
    
    // this functions checks that each course name is correct
    func testCourseName() throws {
        XCTAssertEqual(testStudy[0].courseName, "Big Data Analytics and Social Media")
        XCTAssertEqual(testStudy[1].courseName, "Virtual and Augmented Reality")
        XCTAssertEqual(testStudy[2].courseName, "Mobile Application Development")
    }
    
    // this function checks that each course has the correct amount of tasks
    func testTasksCount() throws {
        XCTAssertEqual(testStudy[0].tasks.count, 2)
        XCTAssertEqual(testStudy[1].tasks.count, 2)
        XCTAssertEqual(testStudy[2].tasks.count, 2)
    }
    
    // this function checks whether .isCompleted toggle works correctly
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
