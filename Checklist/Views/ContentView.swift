//
//  ContentView.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var model: DataModel
    @State var myTitle = "My Courses"
    var body: some View {
        NavigationView {
            
            VStack {
                
                TitleView(title: "University Tasks", img: "book")
                
                List {
                    ForEach(model.Courses,id:\.self) {
                        studyTask in Text(studyTask.course)
                        
                    }.onDelete { idx in model.Courses.remove(atOffsets: idx)
                        
                    }.onMove { idx, i in
                        model.Courses.move(fromOffsets: idx, toOffset: i)
                    }
                }
            }.navigationTitle(myTitle)
                .navigationBarItems(leading: EditButton(), trailing: Button("+"){
                    model.Courses.append(Study(courseCode: "New", courseName: "Course"))
                })
        }
    }
}
