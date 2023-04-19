//
//  ChecklistApp.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

@main
struct ChecklistApp: App {
    @StateObject var model: DataModel = DataModel.getDataModel()
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
