//
//  ContentView.swift
//  Guess The Country
//
//  Created by Osamah alyousef on 28/06/2024.
//

import SwiftUI
struct FlagImage: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .shadow(radius: 10)
    }
    
    
}
struct ContentView: View {
    @State private var showScore = false
    @State private var score = ""
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria",  "spain", "uk", "ukraine", "us"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...1)
    @State private var scoreNum = 0
    @State private var questions = 1
    @State private var isEight = false
    
    func flagTap(_ num: Int) {
        if num == correctAnswer {
            score = "YAY!"
            scoreNum += 1
        } else {
            score = "NAY :( Thats the flag of \(countries[num])"
        }
        showScore = true
        questions += 1
        if questions > 8 {
            isEight = true
        }
    }
    
    func askQ() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...1)
        showScore = false
    }
    
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...1)
        scoreNum = 0
        questions = 1
        isEight = false
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 40) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                        
                        if !isEight {
                            ForEach(0..<2) { number in
                                Button {
                                    flagTap(number)
                                } label: {
                                    Image(countries[number])
                                }
                                .alert(score, isPresented: $showScore) {
                                    Button("Next", action: askQ)
                                } message: {
                                    Text("Your score is: \(scoreNum)")
                                }
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Text("Your score is: \(scoreNum)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    
                    if isEight {
                        VStack {
                            Text("")
                                .alert("Game Over", isPresented: $isEight) {
                                    Button("Reset", action: reset)
                                } message: {
                                    Text("Your final score is: \(scoreNum)")
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
