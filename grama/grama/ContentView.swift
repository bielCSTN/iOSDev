//
//  ContentView.swift
//  grama
//
//  Created by Biel on 06/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    @AppStorage("highestScore") private var highestScore = 0
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Insira uma Palavra", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section{
                    ForEach(usedWords, id: \.self) { word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel("\(word)")
                        .accessibilityHint("\(word.count) letters")
                    }
                }
                
                Section("Pontuação "){
                    Text("\(score) pontos").font(.title2)
                        .foregroundColor( score == highestScore ? .brown : score > 0 ? .blue : .red)
                }
                
                Section("Recorde 🏆") {
                    Text("\(highestScore) pontos").font(.title2)
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("Nova Palavra", action: startGame)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else {
            wordError(title: "Essa palavra já foi!", message: "Seja mais original.")
            score -= 5
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Palavra Impossível!", message: "Não dá pra tirar '\(answer)' de '\(rootWord)'!")
            score -= 5
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Oi???", message: "De onde você tirou isso?!?")
            score -= 5
            return
        }
        
        guard isSame(word: answer) else {
            wordError(title: "Sabe o que tá em negrito?", message: "É A MESMA PALAVRA!")
            score -= 5
            return
        }
        
        guard lessThanThree(word: answer) else {
            wordError(title: "Sou pequeno demaaaais 🎶", message: "Insira uma palavra maior.")
            score -= 5
            return
        }
        
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        
        calculateScore()
        newWord = ""
    }
    
    func startGame() {
        withAnimation {
            if let startWordsURL = Bundle.main.url(forResource: "palavras", withExtension: "txt") {
                if let startWords = try? String(contentsOf: startWordsURL) {
                    let allWords = startWords.components(separatedBy: "\n")
                    rootWord = allWords.randomElement() ?? "string"
                    usedWords = [String]()
                    score = 0
                    return
                }
            }
            fatalError("Não foi possível carregar palavras.txt")
        }
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word : String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "pt_BR")
        
        return mispelledRange.location == NSNotFound
    }
    
    func isSame(word: String) -> Bool {
        if word != rootWord {
            return true
        }
        return false
    }
    
    func lessThanThree(word: String) -> Bool{
        if word.count >= 3 {
            return true
        }
        return false
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func calculateScore() {
        score += (newWord.count + 5)
        
        if score > highestScore {
            highestScore = score
        }
    }

 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
