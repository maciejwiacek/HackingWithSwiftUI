//
//  project_7App.swift
//  project-7
//
//  Created by Maciej Wiącek on 09/01/2025.
//

import SwiftData
import SwiftUI

@main
struct project_7App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
