//
//  DataModel.swift
//  Checklist
//
//  Created by Brianne Byer on 23/3/2023.
//

import Foundation

struct Study: Identifiable {
    var id = UUID()
    var course: String
    var task: String
    var checkbox: String
}

var testStudy = [
    Study(course: "3032ICT" , task: "Complete quiz", checkbox: "checkmark.square"),
    Study(course: "3705ICT" , task: "Start Assignment 1", checkbox: "checkmark.square.fill"),
    Study(course: "3705ICT", task: "Read chapter", checkbox: "checkmark.square.fill"),
    Study(course: "3701ICT" , task: "Create prototype", checkbox: "checkmark.square")
]
