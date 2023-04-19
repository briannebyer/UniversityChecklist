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
            // if edit mode is active, user can edit courseName and courseCode
            if mode?.wrappedValue == .active {
                HStack(alignment: .center){
                    TextField("Rename course?", text: $course.courseName)
                        .font(.caption)
                        .padding()
                        .foregroundColor(.gray)
                    TextField("Rename code?", text: $course.courseCode)
                        .font(.caption)
                        .padding()
                        .foregroundColor(.gray)
                        }
                        // need to saveData somewhere?
                    } else {
                        DetailTitleView(titleName: course.courseName, titleCode: course.courseCode)
                        
                        }
            
            VStack {
                List {
                    ForEach(course.tasks, id:\.id) {task in
                        HStack {
                            // if task is ticked/completed, shows a filled checkmark, if not completed, shows unfilled checkmark
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill": "circle")
                            // makes checkmark blue
                                .foregroundColor(.blue)
                            
                            // when tapped by user, toggles if task is completed or not
                                .onTapGesture {
                                    // maybe have a function in DataModel for toggle checkbox?
//                                    print(task.isCompleted)
                                    task.isCompleted.toggle()
//                                    print(task.isCompleted)  // used to confirm onTapGesture toggle was working during debugging
                                    saveData()
                                }
                            
                                // shows task description
                                Text(task.description)
                                    .font(.subheadline)
                        }
                                            
                    // similar to ContentView, but targets course tasks, removes task
                }.onDelete { idx in
                    // if in edit mode, user can delete tasks
                    if mode?.wrappedValue == .active {
                        course.tasks.remove(atOffsets: idx)
                        // save to JSON file
                        saveData()
                    }
                    // allows user to move tasks
                }.onMove { idx, newOffset in
                    // if in edit mode, user can re-arrange tasks
                    if mode?.wrappedValue == .active {
                        course.tasks.move(fromOffsets: idx, toOffset: newOffset)
                        // save to JSON file
                        saveData()
                    }
                } // add new task only appears in EditMode
                    if mode?.wrappedValue == .active {
                        Button(action: {
                            // add new task
                            let newTask = StudyTask(description: newTaskDescription, isCompleted: false)
                            course.tasks.append(newTask)
                            // save to JSON file
                            saveData()
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
                Button(action: { showResetConfirmation = true}) {
                                    Text("Reset")
                                }
                                .disabled(course.tasks.count == 0)
                                .alert(isPresented: $showResetConfirmation) {
                                    Alert(
                                        title: Text("Reset Checklist"),
                                        message: Text("Are you sure you want to reset the checklist?"),
                                        primaryButton: .destructive(Text("Reset")) {
                                            // resets the tasks
                                            undoTasks = course.tasks
                                            for i in 0..<course.tasks.count {
                                                // goes through all tasks in course, by settings isCompleted to false
                                                course.tasks[i].isCompleted = false
                                                // save to JSON file
                                                saveData()
                                            }
                                        },
                                        secondaryButton: .cancel(Text("Undo")) {
                                            // does nothing, does not reset
                                        }
                                    )
                                }
                            }
                    )
            }
    }
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
