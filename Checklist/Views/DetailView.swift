//
//  DetailView.swift
//  Checklist
//
//  Created by Brianne Byer on 4/4/2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var course: Study
    @State var displayName: String = ""
    @State var displayCode: String = ""
    // for reset functionality
    @State var showResetConfirmation = false
    // for undo functionality, returning to previous state
    @State var undoTasks: [StudyTask]?
    
    var body: some View {
        VStack {
            TitleView(title: course.courseName, img: "star.fill")
            Spacer()
            HStack(alignment: .center) {
                TextField("Course name?", text: $displayName)
                    .padding()
                    .foregroundColor(.gray)
                TextField("Course code?", text: $displayCode)
                    .padding()
                    .foregroundColor(.gray)
            }
            List {
                ForEach(course.tasks) { task in
                    HStack {
                        // if task is ticked/completed, shows a filled checkmark, if not completed, shows unfilled checkmark
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill": "circle")
                        // makes checkmark blue
                            .foregroundColor(.blue)
                        // when tapped by user, toggles if task is completed or not
                            .onTapGesture {
                                if let idx = course.tasks.firstIndex(of: task) {
                                    course.tasks[idx].isCompleted.toggle()
                                }
                            }
                        // shows task description
                        Text(task.description)
                    }
                    // similar to ContentView, but targets course tasks, removes task
                }.onDelete { idx in
                    course.tasks.remove(atOffsets: idx)
                    // when in editing, allows user to move tasks
                }.onMove { idx, newOffset in
                    course.tasks.move(fromOffsets: idx, toOffset: newOffset)
                }
            }
        }
        .navigationBarItems(
            trailing: HStack {
                // only displays EditButton if there are any tasks to edit
                if course.tasks.count > 0 {
                    EditButton()
                }
                /* Not needed for M2, maybe for Assignment 2?
                Button(action: {
                    // add new task
                    let newTask = StudyTask(description: "New task", isCompleted: false)
                    course.tasks.append(newTask)
                }){
                    Image(systemName:"+")
                }*/
                Button(action: {
                    // show confirmation dialog
                    showResetConfirmation = true
                    // stores current state of the tasks
                    undoTasks = course.tasks
                    // resets by going through all tasks in course, by setting isCompleted to false
                    for i in 0..<course.tasks.count {
                        course.tasks[i].isCompleted = false
                    }
                }) {
                    Text("Reset")
                }
                //
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
                            }
                        },
                        // restores to previous state if user clicks cancel
                        secondaryButton: .cancel(Text("Cancel")) {
                            course.tasks = undoTasks ?? course.tasks
                        }
                    )
                }
            }
        )
        .onAppear {
            displayName = course.courseName
            displayCode = course.courseCode
        }
        .onDisappear {
            course.courseName = displayName
            course.courseCode = displayCode
        }
    }
}
