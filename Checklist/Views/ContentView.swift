//
//  ContentView.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: DataModel
    // handles navigation via index
    @State var selectedIndex: Int?
    var body: some View {
        NavigationView {
            VStack {
                
                TitleView(title: "University Courses", img: "book")
                
                // removing '$', binding, as it is no longer required
                List {
                    ForEach(model.courses,id:\.self) {
                        // studyTask not defined in the ForEach loop, changed to $course instead
                        course in
                        // takes user to specific course, via its index
                        NavigationLink(destination: DetailView(model: model, selectedIndex: model.courses.firstIndex(of: course))) {
                            VStack(alignment: .leading){
                                Text(course.courseCode)
                                    .font(.subheadline)
                                Text(course.courseName)
                                    .font(.caption)
                            }.padding()
                        }
                        
                    }.onDelete { idx in
                        //
                        model.courses.remove(atOffsets: idx)
                        // save to JSON file
                        model.save()
                    }.onMove { idx, i in
                        model.courses.move(fromOffsets: idx, toOffset: i)
                        // save to JSON file
                        model.save()
                    }
                    // ensures TitleView and navigationBarItems look aesthetically pleasing
                }.navigationBarTitle("", displayMode: .inline)
            }
            .navigationBarItems(leading: EditButton(), trailing: Button("+"){
                // added tasks: [] to the Study initializer, required parameter for the Study struct.
                model.courses.append(Study(courseCode: "New", courseName: "Course", tasks: []))
                // save to JSON file
                model.save()
            })
        }
    }
}
