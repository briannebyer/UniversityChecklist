//
//  ChecklistApp.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

@main
struct ChecklistApp: App {
    @StateObject var model: DataModel = DataModel(courses: [Study]())
    var body: some Scene {
        WindowGroup {
            // does not require binding anymore, as a class is a reference type
            ContentView(model: model)
        }
    }
}
