//
//  ExpensesListView.swift
//  project-7
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import SwiftData
import SwiftUI

struct ExpensesListView: View {
    @Query var expenses: [ExpenseItem]
    @Environment(\.modelContext) var modelContext
    
    init(sortBy: [SortDescriptor<ExpenseItem>], showing type: String = "") {
        _expenses = Query(filter: #Predicate<ExpenseItem> { expense in
            if type == "" {
                return true
            } else {
                if expense.type == type {
                    return true
                } else {
                    return false
                }
            }
        }, sort: sortBy)
    }
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                ExpenseItemView(name: expense.name, type: expense.type, amount: expense.amount)
            }
            .onDelete(perform: removeItems)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpensesListView(sortBy: [SortDescriptor(\ExpenseItem.name)])
}
