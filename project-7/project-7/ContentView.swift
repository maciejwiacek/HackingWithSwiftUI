//
//  ContentView.swift
//  project-7
//
//  Created by Maciej Wiącek on 09/01/2025.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

enum Locales {
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
}

struct ExpenseItemView: View {
    let name: String
    let type: String
    let amount: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(type)
            }
            
            Spacer()
            
            Text(amount, format: .currency(code: Locales.currencyCode))
                .foregroundStyle(
                    amount <= 10 ? .red :
                    amount <= 100 ? .black :
                    .green
                )
        }
    }
}

struct TopButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .foregroundStyle(.white)
                .cornerRadius(8)
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var showingBusiness = true
    @State private var sortAscending = true

    var filteredExpenses: [ExpenseItem] {
        let filtered = expenses.items.filter { $0.type == (showingBusiness ? "Business" : "Personal") }
        return filtered.sorted { sortAscending ? $0.amount < $1.amount : $0.amount > $1.amount }
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TopButton(
                        title: showingBusiness ? "Business" : "Personal",
                        color: .blue,
                        action: { showingBusiness.toggle() })
                    
                    TopButton(
                        title: sortAscending ? "Sort ↓" : "Sort ↑",
                        color: .green,
                        action: { sortAscending.toggle() })
                }
                .padding(.horizontal)

                List {
                    ForEach(filteredExpenses) { item in
                        ExpenseItemView(name: item.name, type: item.type, amount: item.amount)
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let itemToRemove = filteredExpenses[offset]
            if let index = expenses.items.firstIndex(where: { $0.id == itemToRemove.id }) {
                expenses.items.remove(at: index)
            }
        }
    }
}


#Preview {
    ContentView()
}
