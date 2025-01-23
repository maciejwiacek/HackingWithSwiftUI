//
//  Job.swift
//  project-12
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import Foundation
import SwiftData

@Model
class Job {
    var name: String
    var priority: Int
    // Creating a relationship with User Model
    var owner: User?
    
    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
