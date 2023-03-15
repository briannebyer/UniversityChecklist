//
//  ContentView.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

var studyTask = [["3032ICT", "Complete quiz", "checkmark.square"],["3705ICT","Start Assignment 1", "checkmark.square.fill"], ["3705ICT", "Read chapter", "checkmark.square.fill"], ["3701ICT", "Create prototype", "checkmark.square"]]

struct ContentView: View {
    var body: some View {
        VStack {
            List {
                ForEach(studyTask, id:\.self){
                    studyTask in HStack{
                        Text(studyTask[0])
                        Text(studyTask[1])
                        Image(systemName:studyTask[2])
                            }
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

