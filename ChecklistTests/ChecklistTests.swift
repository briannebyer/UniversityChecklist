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

    func testExample() throws {
        
        let firstTask = testStudy[0]
        let secondTask = testStudy[1]
        let thirdTask = testStudy[2]
        let fourthTask = testStudy[3]
        
        // check that each task has correct course code
        XCTAssertEqual(firstTask.course, "3032ICT")
        XCTAssertEqual(secondTask.course, "3705ICT")
        XCTAssertEqual(thirdTask.course, "3705ICT")
        XCTAssertEqual(fourthTask.course, "3701ICT")
        
        // check that each task has correct description
        
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
