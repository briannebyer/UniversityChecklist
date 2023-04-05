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
    var body: some View {
        VStack {
            
            TitleView(title: course.courseName, img: "star.fill")
            Spacer()
            
            HStack (alignment: .center){
                TextField("Course name?", text: $displayName)
                    .padding()
                    .foregroundColor(.gray)
                TextField("Course code?", text: $displayCode)
                    .padding()
                    .foregroundColor(.gray)
            }
            
            List(course.tasks) { task in
                            HStack {
                                Text(task.description)
                                if task.isCompleted {
                                    Image(systemName: "checkmark")
                                } 
                            }
                    }
        
        }.onAppear{
            displayName = course.courseName
            displayCode = course.courseCode
        }.onDisappear {
            course.courseName = displayName
            course.courseCode = displayCode
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(course:.constant(testStudy[0]))
    }
}
