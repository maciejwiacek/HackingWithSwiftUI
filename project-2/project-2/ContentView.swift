//
//  ContentView.swift
//  project-2
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import SwiftUI

struct FlagImage: View {
    var flag: String
    
    var body: some View {
        Image(flag)
            .clipShape(.capsule)
            .shadow(radius: 10)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var showingEnd = false
    @State private var endTitle = ""
    @State private var endMessage = ""
    
    @State private var animationAmount = 0
    @State private var chosenFlag = -1
    
    @State private var score = 0
    
    @State private var roundNumber = 1

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flag: countries[number])
                                .rotationEffect(number == chosenFlag ? .degrees(Double(animationAmount)) : .degrees(0))
                                .opacity(chosenFlag == -1 || number == chosenFlag ? 1 : Double(animationAmount) / 1000)
                                .scaleEffect(chosenFlag == -1 || number == chosenFlag ? 1: Double(animationAmount) / 500)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert(endTitle, isPresented: $showingEnd) {
            Button("Start Again", action: restartGame)
        } message: {
            Text(endMessage)
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(score)\nThat's correct!"
        } else {
            if score > 0 {
                score -= 1
            }
            scoreTitle = "Wrong"
            scoreMessage = "Your score is \(score)\nThat's the flag of \(countries[number])"
        }

        chosenFlag = number
        withAnimation {
            animationAmount = 360
        }
        showingScore = true
    }

    func askQuestion() {
        if roundNumber == 8 {
            endTitle = "Well Done!"
            endMessage = "You scored \(score)/\(roundNumber)\nWould you like to play again?"
            showingEnd = true
            return
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        chosenFlag = -1
        animationAmount = 0
        roundNumber += 1
    }
    
    func restartGame() {
        score = 0
        roundNumber = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
