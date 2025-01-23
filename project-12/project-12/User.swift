//
//  User.swift
//  project-12
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import Foundation
import SwiftData

// Creating an example data model

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    // Creating a relationship with Job Model
    // The next time our app launches SwiftData will silently add the jobs property to all existing users, giving them an empty array by default
    // It is called migration - adding or deleting properties in our models, Swift can handle easy ones by itself
    // When we used modelContainer in our App struct we passed User.self and because there's relationship between User and Job, we don't need to pass the Job there
    // You also don't need to update a Query
//    var jobs = [Job]()
    
    // If we want to delete all user's job objects to be deleted at the same time with a user, you need to specify that
    // It's done using @Relationship macro, providing a delete rule that describes how Job objects should be handled when their owning User is deleted
    // The default is .nullify (owner gets set to nil), .cascade means deleting a User automatically delets all its Job objects
    // It's called cascade, because it keeps going for all related objects (if Job had a location relationship it would also be deleted)
    @Relationship(deleteRule: .cascade) var jobs = [Job]()
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
