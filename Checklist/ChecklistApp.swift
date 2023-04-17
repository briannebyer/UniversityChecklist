//
//  ChecklistApp.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

@main
struct ChecklistApp: App {
    @State var model: DataModel = DataModel()
    var body: some Scene {
        WindowGroup {
            ContentView(model: $model)
        }
    }
}
