//
//  ContentView.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: DataModel
    var body: some View {
        NavigationView {
            // if all data in model is loaded, show the following...
            if(model.loadingCompleted){
                VStack {
                    TitleView(title: "University Courses", img: "book")
                    List {
                        // remove binding as not needed, using Observable & Publish
                        ForEach(model.Courses, id:\.id) {
                            // studyTask not defined in the ForEach loop, changed to $course instead
                            course in
                            NavigationLink(destination: DetailView(course: course)){
                                VStack(alignment: .leading){
                                    Text(course.courseCode)
                                        .font(.subheadline)
                                    Text(course.courseName)
                                        .font(.caption)
                                }.padding()
                            }
                            
                        }.onDelete { idx in
                            model.Courses.remove(atOffsets: idx)
                            // save to JSON file
                            saveData()
                        }.onMove { idx, i in
                            model.Courses.move(fromOffsets: idx, toOffset: i)
                            // save to JSON file
                            saveData()
                        }
                        // ensures TitleView and navigationBarItems look aesthetically pleasing
                    }.navigationBarTitle("", displayMode: .inline)
                }
                .navigationBarItems(leading: EditButton(), trailing: Button("+"){
                    // added tasks: [] to the Study initializer, required parameter for the Study struct.
                    model.Courses.append(Study(courseCode: "XXXICT", courseName: "Course Name", tasks: []))
                    // save to JSON file
                    saveData()
                })
                // if data is not loaded, show progress view
            } else {
                VStack {
                    ProgressView().foregroundColor(.blue)
                        .padding()
                    Text("Loading...")
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
        }
    }
}
            
