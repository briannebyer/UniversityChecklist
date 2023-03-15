//
//  ContentView.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

var studyTask = ["Complete quiz", "Start Assignment 1", "Read chapter", "Create prototype"]

struct ContentView: View {
    var body: some View {
        VStack {
            List {
                ForEach(studyTask, id:\.self){
                    goal in Text(goal)
                            }
                }
            }
        }
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
