//
//  ContentView.swift
//  RPSPlus
//
//  Created by Brandon Coston on 2/28/23.
//

import SwiftUI

enum RPS: String, CaseIterable {
    case rock = "🪨"
    case paper = "📃"
    case scissors = "✂️"
}

enum outcome {
    case win, lose
}



struct ContentView: View {
    var moves: [RPS] = [.rock, .paper, .scissors]
    @State private var currentIndex = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var currentScore = 0
    @State private var round = 1
    @State private var showingFinalScore = false
    
    var winningIndex: Int {
        let win = shouldWin ? currentIndex + 1 : currentIndex - 1
        if win < 0 {
            return 2
        } else if win > 2 {
            return 0
        } else {
            return win
        }
    }
    
    
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text("Round \(round)")
                    .font(.largeTitle.bold())
                Text("Current Score: \(currentScore)")
                    .font(.subheadline.weight(.semibold))
            }
            
            Spacer()
            
            VStack {
                Text("The opponent has made their choice")
                Text(shouldWin ? "try to pick the winner" : "try to pick the loser")
            }
            HStack {
                ForEach(RPS.allCases, id: \.self) { value in
                    Spacer()
                    Button() {
                        calculateWinner(value)
                        nextRound()
                    } label: {
                        Text(value.rawValue)
                            .font(.system(size: 80))
                    }
                }
                Spacer()
            }
            
            Spacer()
            Spacer()
            Spacer()
        }
        .padding()
        .alert("Game Over", isPresented: $showingFinalScore) {
            Button("Play Again") {
                restartGame()
            }
        } message: {
            Text("Final Score: \(currentScore)")
        }
    }
    
    func calculateWinner(_ value: RPS) {
        let winningChoice = moves[winningIndex]
        if winningChoice == value {
            currentScore += 1
        } else {
            currentScore -= 1
        }
    }
    
    func nextRound() {
        round += 1
        showingFinalScore = round > 10
        round = round > 10 ? 10 : round
        currentIndex = Int.random(in: 0..<3)
        shouldWin.toggle()
    }
    
    func restartGame() {
        round = 1
        currentIndex = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        currentScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
