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
                    studyTask in ListRowView(item: studyTask)
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


struct ListRowView: View {
    var item: [String]
    var body: some View {
        HStack{
            Text(item[0]).bold().padding()
            Text(item[1])
            Spacer()
            Image(systemName:item[2])
        }
    }
}
