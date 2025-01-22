//
//  project_11App.swift
//  project-11
//
//  Created by Maciej Wiącek on 22/01/2025.
//

import SwiftData
import SwiftUI

@main
struct project_11App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
