//
//  DetailView.swift
//  Checklist
//
//  Created by Brianne Byer on 4/4/2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var Course: Study
    @State var displayName: String = ""
    var body: some View {
        VStack {
            
            TitleView(title: Course.courseName, img: "star.fill")

            TextField("Change course code here", text: $displayName)
            
            Spacer()
            
        
        }.onAppear{
            displayName = Course.courseName
        }.onDisappear {
            Course.courseCode = displayName
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(Course:.constant(testStudy[0]))
    }
}
