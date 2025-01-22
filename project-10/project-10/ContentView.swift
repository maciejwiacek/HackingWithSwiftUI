//
//  ContentView.swift
//  project-10
//
//  Created by Maciej Wiącek on 16/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order().load()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    .onChange(of: order.type) { order.save() }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                        .onChange(of: order.quantity) { order.save() }
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                        .onChange(of: order.specialRequestEnabled) { order.save() }
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                            .onChange(of: order.extraFrosting) { order.save() }
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                            .onChange(of: order.addSprinkles) { order.save() }
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
