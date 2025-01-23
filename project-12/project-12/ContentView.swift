//
//  ContentView.swift
//  project-12
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    //    // We can use filter in Query, we have to give him a #Predicate (fancy word for a test we're going to apply)
    //    // That gives us a single object instance (every item in storage) and we need to return true (show) or false (don't show)
    //    // We can use sort in our Query, to sort the items (we can also pass him the array of SortDescriptors)
    //    @Query(filter: #Predicate<User> { user in
    //        // #Predicate allows only limited number of expressions and we have to provide him with full if-elses (it's not exactly Swift)
    //        // localizedStandardContains - like a contain but not case sensitive
    //        if user.name.localizedStandardContains("R") {
    //            if user.city == "London" {
    //                return true
    //            } else {
    //                return false
    //            }
    //        } else {
    //            return false
    //        }
    //    }, sort: \User.name) var users: [User]

    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]

    var body: some View {
        NavigationStack {
            UsersView(
                minimumJoinDate: showingUpcomingOnly ? .now : .distantPast,
                sortOrder: sortOrder
            )
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    // Delete all existing objects
                    try? modelContext.delete(model: User.self)

                    let first = User(
                        name: "Ed Sheeran", city: "London",
                        joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(
                        name: "Rosa Diaz", city: "New York",
                        joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(
                        name: "Roy Kent", city: "London",
                        joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(
                        name: "Johnny English", city: "London",
                        joinDate: .now.addingTimeInterval((86400 * 10)))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
                
                Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                    showingUpcomingOnly.toggle()
                }
                
                // To make a picker look better in toolbar, we can wrap it in Menu
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                        
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

/*
 We can sync all user's data with iCloud and often it takes no code to do so.
 However we need Apple Developer account
 You just need to enable the iCloud capability
 1. Add an iCloud capability in project's target
 2. Enable CloudKit
 3. Click plus icon, to add a new container for storing data (call it "iCloud.<bundleid>")
 4. Add a Background Modes capability
 5. Check Remote Notification (it allows app to be notified when data changes in iCloud, so it can be synced locally)
 
 Last thing to do is making sure that your model meets iCloud's requirements:
 - All properties must be optional or have default values
 - All relationships must be optional
 
 Then if you don't want to have optionals everywhere you can store them in read-only computed properties
 
 IF YOU ENCOUNTER ANY PROBLEMS USE REAL DEVICE NOT SIMULATOR
 */
