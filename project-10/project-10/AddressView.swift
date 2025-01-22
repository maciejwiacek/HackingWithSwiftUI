//
//  AddressView.swift
//  project-10
//
//  Created by Maciej Wiącek on 17/01/2025.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                    .onChange(of: order.name) { order.save() }
                TextField("Street Address", text: $order.streetAddress)
                    .onChange(of: order.streetAddress) { order.save() }
                TextField("City", text: $order.city)
                    .onChange(of: order.city) { order.save() }
                TextField("Zip", text: $order.zip)
                    .onChange(of: order.zip) { order.save() }
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order().load())
}
