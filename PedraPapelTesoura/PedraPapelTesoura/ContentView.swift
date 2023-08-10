//
//  ContentView.swift
//  PedraPapelTesoura
//
//  Created by Biel on 03/01/23.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["✊", "✋", "✌️"]
    
    @State private var appChoice = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var rounds = 1
    
    @State private var wins = 0
    @State private var loses = 0
    @State private var draws = 0
    @State private var remaining = 10
    
    @State private var showingResult = false
    @State private var endGame = false
    @State private var result = ""
    
    private var correctAnswer: Int {
        return ((appChoice + 1) % 3)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Section{
                Text("Computador Escolhe:")
                Text("\(self.moves[appChoice])").font(.system(size: 80))
            }
            Spacer()
            VStack{
                Text("Pedra, Papel, Tesoura!").font(.largeTitle.weight(.bold))
                Text("Rodadas Restantes: \(remaining)")
            }
            Spacer()
            
            Section{
                Text("Você Escolhe:")
                HStack{
                    ForEach(0..<3, id: \.self) { index in
                        Button(action: {self.checkAnswer(usersAnswer: index)}) {
                            Text("\(self.moves[index])").font(.system(size: 90))
                        }
                      }
                    }
                }
            Spacer()
            VStack{
                Text("Pontos: \(score)").foregroundColor(.blue).font(.title2)
                HStack(spacing: 20) {
                    Text("Vitórias: \(wins)").foregroundColor(.green)
                    Text("Empates: \(draws)").foregroundColor(.yellow)
                    Text("Derrotas: \(loses)").foregroundColor(.red)
                }
            }
            Spacer()
        } .alert(result, isPresented: $showingResult) {
            Button("Continuar", action: continueGame)
        } message: {
            Text("Agora você tem \(score) pontos!")
        } .alert("Fim de Jogo!", isPresented: $endGame) {
            Button("Reiniciar", action: newGame)
        } message: {
             Text("Você marcou \(score) pontos!")
        }
        
        .padding()
        }
    
    func checkAnswer(usersAnswer: Int){
        if usersAnswer == correctAnswer {
            score += 5
            result = "Você venceu!"
            wins += 1
        } else if usersAnswer == appChoice{
            result = "Empate!"
            draws += 1
        } else {
            score -= 5
            result = "Você perdeu!"
            loses += 1
        }
        showingResult = true
        
        if rounds == 10 {
            showingResult = false
            endGame = true
        }
    }
    
    func continueGame() {
        appChoice = Int.random(in: 0...2)
        rounds += 1
        remaining -= 1
    }
    
    func newGame() {
        continueGame()
        score = 0
        rounds = 1
        wins = 0
        draws = 0
        loses = 0
        remaining = 10
    }
    
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
