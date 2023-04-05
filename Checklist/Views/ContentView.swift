//
//  ContentView.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var model: DataModel
    var body: some View {
        NavigationView {
            VStack {
                
                TitleView(title: "University Tasks", img: "book")
                
                List {
                    ForEach($model.Courses,id:\.self) {
                        // studyTask not defined in the ForEach loop, changed to $course instead
                        $course in
                        NavigationLink(destination: DetailView(course: $course)){
                            Text(course.courseCode)
                                .bold()
                                .fixedSize()
                                .padding()
                            Text(course.courseName)
                        }
                        
                    }.onDelete { idx in model.Courses.remove(atOffsets: idx)
                        
                    }.onMove { idx, i in
                        model.Courses.move(fromOffsets: idx, toOffset: i)
                    }
                }.navigationBarTitle("", displayMode: .inline)
            }
            .navigationBarItems(leading: EditButton(), trailing: Button("+"){
                // added tasks: [] to the Study initializer, required parameter for the Study struct.
                model.Courses.append(Study(courseCode: "New", courseName: "Course", tasks: []))
            })
        }
    }
}
