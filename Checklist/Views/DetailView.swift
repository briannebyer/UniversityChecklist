//
//  DetailView.swift
//  Checklist
//
//  Created by Brianne Byer on 4/4/2023.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var course: Study
    @State var tmpName: String = ""
    @State var tmpCode: String = ""
    // allowing the user to add a new task and change said description
    @State var newTaskDescription = ""
    // for reset functionality
    @State var showResetConfirmation = false
    // for undo functionality, returning to previous state
    @State var undoTasks: [StudyTask]?
    // for the ability to return to ContentView
    @Environment(\.presentationMode) var presentationMode
    // for ability for user to enter Edit mode
    @Environment(\.editMode) var mode
    
    var body: some View {
        VStack {
            
            if mode?.wrappedValue == .active {
                TextField("Rename Course?", text: $course.courseName)
                TextField("Rename Code?", text: $course.courseCode)
            } else {
                DetailTitleView(title: course.courseName, img: "star.fill")
                Text(course.courseCode)
            }
        
            List {
                ForEach(course.tasks, id:\.id) {task in
                    HStack {
                        // if task is ticked/completed, shows a filled checkmark, if not completed, shows unfilled checkmark
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill": "circle")
                        // makes checkmark blue
                            .foregroundColor(.blue)
                        
                        // when tapped by user, toggles if task is completed or not
                            .onTapGesture {
                                //Maybe have a function in DataModel for toggle checkbox?
                                task.isCompleted = !task.isCompleted
                                saveData()
                                //Why won't this update when toggled?!?
                            }
                        
                        
                        if mode?.wrappedValue == .active {
                            //Add code to change task decription in edit mode
                        } else {
                            // shows task description
                            Text(task.description)
                                .font(.subheadline)
                        }
                        
                    }
                    
                    // similar to ContentView, but targets course tasks, removes task
                }.onDelete { idx in
                    // if in edit mode, user can delete tasks
                    if mode?.wrappedValue == .active {
                        course.tasks.remove(atOffsets: idx)
                        // save to JSON file
                        saveData()
                    }
                    // Allows user to move tasks
                }.onMove { idx, newOffset in
                    // if in edit mode, user can re-arrange tasks
                    if mode?.wrappedValue == .active {
                        course.tasks.move(fromOffsets: idx, toOffset: newOffset)
                        // save to JSON file
                        saveData()
                    }
                }
            }
            VStack {
                Button(action: {
                    // add new task
                    let newTask = StudyTask(description: newTaskDescription, isCompleted: false)
                    course.tasks.append(newTask)
                    // reset new task description, for when a new task, with a new description is added
                    newTaskDescription = ""
                        }){
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                TextField("New task?", text: $newTaskDescription)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                            
                        }
                }
            
                
        
        // ensures default back button is hidden
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            // adds "Back" button
            leading: Button(action: {
                // takes back to ContentView
                presentationMode.wrappedValue.dismiss()
            }){
                Text("Back")
            },
            trailing: HStack {
                // removed conditional for EditButton
               EditButton()
            }
        )
//        .onAppear {
//            tmpName = course.courseName
//            tmpCode = course.courseCode
//            // ???
//            saveData()
//        }
//        .onDisappear {
//            course.courseName = tmpName
//            course.courseCode = tmpCode
//            // ???
//            saveData()
//
//        }
    }
}
}


// My original code for DetailView
//
//import SwiftUI
//
//struct DetailView: View {
//    @ObservedObject var course: Study
//
//    @State var tmpName: String = ""
//    @State var tmpCode: String = ""
//    // allowing the user to add a new task and change said description
//    @State var newTaskDescription = ""
//    // for reset functionality
//    @State var showResetConfirmation = false
//    // for undo functionality, returning to previous state
//    @State var undoTasks: [StudyTask]?
//    // for the ability to return to ContentView
//    @Environment(\.presentationMode) var presentationMode
//    // for ability for user to enter Edit mode
//    @Environment(\.editMode) var mode
//
//    // instance of DataModel
////    @ObservedObject var dataModel: DataModel
//
//    var body: some View {
//        VStack {
////            TitleView(title: course.courseName, img: "star.fill")
//
//
//
//            // if edit mode is active, user can edit course name and code
//            if mode?.wrappedValue == .active {
//                HStack(alignment: .center) {
//                    TextField("Course name?", text: $tmpName)
//                        .font(.caption)
//                        .padding()
//                        .foregroundColor(.gray)
//                    TextField("Course code?", text: $tmpCode)
//                        .font(.caption)
//                        .padding()
//                        .foregroundColor(.gray)
//                }
//                Button("Confirm"){
//                    course.courseName = tmpName
//                    course.courseCode = tmpCode
//                    saveData()
//                }
//            } else {
//                HStack(alignment: .center) {
//                    Text(course.courseName)
//                        .font(.caption)
//                        .padding()
//                        .foregroundColor(.gray)
//                    Text(course.courseCode)
//                        .font(.caption)
//                        .padding()
//                        .foregroundColor(.gray)
//                }
//            }
//            List {
//                ForEach(course.tasks, id:\.id) { task in
//                    HStack {
//                        // if task is ticked/completed, shows a filled checkmark, if not completed, shows unfilled checkmark
//                        Image(systemName: task.isCompleted ? "checkmark.circle.fill": "circle")
//                        // makes checkmark blue
//                            .foregroundColor(.blue)
//                        // when tapped by user, toggles if task is completed or not
//                            .onTapGesture {
//                                // error we up to :)
////                                if let idx = course.tasks.firstIndex(of: task) {
////                                    course.tasks[idx].isCompleted.toggle()
// //                                     // save to JSON file
//  //                                        saveData()
////                                }
//                            }
//                        // shows task description
//                        Text(task.description)
//                            .font(.subheadline)
//
//                    }
//                    // similar to ContentView, but targets course tasks, removes task
//                }.onDelete { idx in
//                    // if in edit mode, user can delete tasks
//                    if mode?.wrappedValue == .active {
//                        course.tasks.remove(atOffsets: idx)
//                        // save to JSON file
//                        saveData()
//                    }
//                    // Allows user to move tasks
//                }.onMove { idx, newOffset in
//                    // if in edit mode, user can re-arrange tasks
//                    if mode?.wrappedValue == .active {
//                        course.tasks.move(fromOffsets: idx, toOffset: newOffset)
//                        // save to JSON file
//                        saveData()
//                    }
//                }
//
//                Button(action: {
//                    // add new task
//                    let newTask = StudyTask(description: newTaskDescription, isCompleted: false)
//                    course.tasks.append(newTask)
//                    // reset new task description, for when a new task, with a new description is added
//                    newTaskDescription = ""
//                        }){
//                            HStack{
//                                Image(systemName: "plus.circle.fill")
//                                TextField("New task?", text: $newTaskDescription)
//                                    .font(.subheadline)
//                                    .foregroundColor(.black)
//                            }
//
//                        }
//                }
//        }
//        // ensures default back button is hidden
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(
//            // adds "Back" button
//            leading: Button(action: {
//                // takes back to ContentView
//                presentationMode.wrappedValue.dismiss()
//            }){
//                Text("Back")
//            },
//            trailing: HStack {
//                // removed conditional for EditButton
//               EditButton()
//                Button(action: {
//                    // show confirmation dialog
//                    showResetConfirmation = true
//                    // stores current state of the tasks
//                    undoTasks = course.tasks
//                    // resets by going through all tasks in course, by setting isCompleted to false
//                    for i in 0..<course.tasks.count {
//                        course.tasks[i].isCompleted = false
//                    }
//                }) {
//                    Text("Reset")
//                }
//                //
//                .disabled(course.tasks.count == 0)
//                .alert(isPresented: $showResetConfirmation) {
//                    Alert(
//                        title: Text("Reset Checklist"),
//                        message: Text("Are you sure you want to reset the checklist?"),
//                        primaryButton: .destructive(Text("Reset")) {
//                            // resets the tasks
//                            undoTasks = course.tasks
//                            for i in 0..<course.tasks.count {
//                                // goes through all tasks in course, by settings isCompleted to false
//                                course.tasks[i].isCompleted = false
//                            }
//                        },
//                        // restores to previous state if user clicks cancel
//                        secondaryButton: .cancel(Text("Undo")) {
//                            course.tasks = undoTasks ?? course.tasks
//                        }
//                    )
//                }
//            }
//        )
////        .onAppear {
////            tmpName = course.courseName
////            tmpCode = course.courseCode
////            // ???
////            saveData()
////        }
////        .onDisappear {
////            course.courseName = tmpName
////            course.courseCode = tmpCode
////            // ???
////            saveData()
////
////        }
//    }
//}
//
