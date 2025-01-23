//
//  ExpenseItemView.swift
//  project-7
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import SwiftUI

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
