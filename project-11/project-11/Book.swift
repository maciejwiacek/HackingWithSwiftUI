//
//  Book.swift
//  project-11
//
//  Created by Maciej Wiącek on 22/01/2025.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: Date
    
    var hasValidInfo: Bool {
        !title.isEmpty && !author.isEmpty && !genre.isEmpty && !review.isEmpty
    }
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date = Date()) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}
