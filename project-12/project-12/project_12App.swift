//
//  project_12App.swift
//  project-12
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import SwiftData
import SwiftUI

@main
struct project_12App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Attatching model container for User model (and its relationships)
        .modelContainer(for: User.self)
    }
}
