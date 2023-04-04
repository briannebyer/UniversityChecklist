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
            
            TitleView(title: Course.courseCode, img: "star.fill")
            
            Text("You can change course code")
            TextField("Change course code here", text: $displayName)
            
            Spacer()
        }.onAppear{
            displayName = Course.courseCode
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
