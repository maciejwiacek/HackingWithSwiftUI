//
//  ExpenseItem.swift
//  project-7
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import Foundation
import SwiftData

@Model
class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
