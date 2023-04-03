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
                    ForEach(model.Courses,id:\.self) {
                        studyTask in Text(studyTask.course)
                    }
                }
            }
        }
    }
}
