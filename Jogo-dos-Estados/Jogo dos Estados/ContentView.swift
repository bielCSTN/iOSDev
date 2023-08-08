//
//  ContentView.swift
//  Jogo dos Estados
//
//  Created by Biel on 22/07/22.
//

import SwiftUI

struct FlagImage: View{
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .resizable()
            .frame(width: 100, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    
    
    // Apresenta Alerta de Erro ou Acerto
    @State private var showScore = false
    
    // Mensagem de Erro ou Acerto
    @State private var scoreTitle = ""

    
    // Lista de Estados - Array sorteado
    @State private var states = [
        "Acre", "Alagoas", "Amapá",
        "Amazonas", "Bahia", "Ceará",
        "Distrito Federal", "Espírito Santo", "Goiás",
        "Maranhão", "Mato Grosso do Sul", "Mato Grosso",
        "Minas Gerais", "Paraná", "Paraíba",
        "Pará", "Pernambuco", "Piauí",
        "Rio Grande do Norte", "Rio Grande do Sul", "Rio de Janeiro",
        "Rondônia", "Roraima", "Santa Catarina",
        "Sergipe", "São Paulo", "Tocantins"
    ].shuffled()
    
    
    // Seleciona o estado que se deve encontrar a bandeira
    @State private var correctAnswer = Int.random(in: 0...2)
    
    // Variável Pontuação e Número de Acertos e Erros
    @State private var score = 0
    @State private var corrects = 0
    @State private var wrongs = 0
    
    @State private var asked = 1
    
    @State private var endGame = false
    
    @State private var selectedFlag = -1
    
    
    
    // Tela do App
    var body: some View {
        // Estilo, Fundo em Gradiente
        ZStack{
            LinearGradient(gradient: Gradient(
                colors: [
                    // Verde
                    Color(red: 49/255, green: 79/255, blue: 64/255),
                    // Amarelo
                    Color(red: 203/255, green: 142/255, blue: 22/255),
                    // Preto
                    .black
                ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Título e Subtítulo
            VStack{
                Spacer()
                Text("Jogo dos Estados 🇧🇷")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                Text("Acerte a Bandeira de cada estado!")
                    .foregroundColor(.white)
                    .font(.title3)
                
                // Caixinha com Estado e Bandeiras
                // Estado da Vez
                VStack(spacing: 15){
                    VStack{
                        Text(states[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    // Exibe as Bandeiras
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                            FlagImage(image: states[number])
                                .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .blur(radius: selectedFlag == -1 || selectedFlag == number ? 0 : 5)
                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0)
                                .animation(.default, value: selectedFlag)
                        }
                    }
                }
                // Estilo
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                // Exibe Pontuação, Erros e Acertos
                Text("Pontos: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                HStack{
                    Text("Acertos: \(corrects)")
                        .foregroundColor(.green)
                        .shadow(radius: 5)
                    
                    Text("Erros: \(wrongs)")
                        .foregroundColor(.red)
                        .shadow(radius: 5)
                }
                Spacer()
                
        }
            .padding()
        }
        // Alerta após clicar na bandeira
        .alert(scoreTitle, isPresented: $showScore){
            Button("Continue", action: askQuestion)
        } message:{
            Text("Sua pontuação: \(score)")
        }
        .alert("Fim de Jogo! 🙅🏻‍♂️", isPresented: $endGame) {
            Button ("Novo Jogo", action: resetGame)
        } message: {
            Text("Você fez \(score) pontos!")
        }
    }
    
    
    // Function após clicar na Bandeira
    func flagTapped(_ number: Int){
        
        selectedFlag = number
        
        if number == correctAnswer{
            scoreTitle = "Certo ✅"
            score += 5
            corrects += 1
        } else {
            scoreTitle = "Errado ❌"
            score -= 5
            wrongs += 1
        }
        
        showScore = true
        
        if asked == 10 {
            endGame = true
            showScore = false
        }
        
    }
    
    // Function para continuar o jogo
    func askQuestion() {
        states.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedFlag = -1
        asked += 1
    }
    
    func resetGame() {
        askQuestion()
        asked = 1
        score = 0
        corrects = 0
        wrongs = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
