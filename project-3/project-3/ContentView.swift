//
//  ContentView.swift
//  project-3
//
//  Created by Maciej Wiącek on 01/01/2025.
//

import SwiftUI

// Custom ViewModifier -> it has to conform to a ViewModifier, which has to have a body method
struct CapsuleTextStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

// Extension to View which makes using custom modifiers easier
extension View {
    func capsuleTextStyling() -> some View {
        modifier(CapsuleTextStyling())
    }
}

// Because our ViewModifier returns some View, it doesn't have to contain modifiers only, it can contain also different views
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black.opacity(0.3))
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

// Reusable View -> it helps us with creating reusable components
struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .capsuleTextStyling()
    }
}

// Challenge
struct BigBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.blue)
    }
}

extension View {
    func bigBlueTitle() -> some View {
        modifier(BigBlueTitle())
    }
}

struct ContentView: View {
    // View as computed property -> helps us to make our body less clutter
    var motto1: some View {
        Text("Draco Dormiens")
    }
    
    // If we have multiple views inside a computed property, we need to give it a ViewBuilder or Group them
    @ViewBuilder var spells: some View {
            Text("Lumos")
            Text("Obliviate")
    }
    
    // View as stored property
    let motto2 = Text("nunquam titillandus")
    
    var body: some View {
        VStack {
            motto1
                .foregroundStyle(.red)
            motto2
                .bigBlueTitle()
            
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
        }
        .padding(30)
        .background(.green)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .watermarked(with: "Made by Mwiacek")
    }
}

#Preview {
    ContentView()
}
