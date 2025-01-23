//
//  EditUserView.swift
//  project-12
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import SwiftData
import SwiftUI

struct EditUserView: View {
    // SwiftData's model objects are using the same observation system that makes @Observable classes work
    // Which means it support extends to the @Bindable
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate, displayedComponents: .date)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        // Creating a custom config and container for passing it as a sample object to preview
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Taylor Swift", city: "Nashville", joinDate: .now)
        
        return EditUserView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
