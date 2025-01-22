//
//  AddView.swift
//  project-7
//
//  Created by Maciej Wiącek on 09/01/2025.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = "New Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locales.currencyCode))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
