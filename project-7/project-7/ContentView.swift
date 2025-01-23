//
//  ContentView.swift
//  project-7
//
//  Created by Maciej Wiącek on 09/01/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    @State private var showingAddExpense = false
    @State private var filteredType = ""
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount, order: .reverse)
    ]

    var body: some View {
        NavigationStack {
            VStack {
                ExpensesListView(sortBy: sortOrder, showing: filteredType)
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView()
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
                
                Button {
                    switch filteredType {
                    case "Personal":
                        filteredType = "Business"
                    case "Business":
                        filteredType = ""
                    default:
                        filteredType = "Personal"
                    }
                } label: {
                    switch filteredType {
                    case "Personal":
                        Text("Show Business")
                    case "Business":
                        Text("Show All")
                    default:
                        Text("Show Personal")
                    }
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.amount, order: .reverse)
                            ])
                        
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                SortDescriptor(\ExpenseItem.name)
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
