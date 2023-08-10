//
//  ContentView.swift
//  Rachador2
//
//  Created by Biel on 26/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]

    
    var totalBruto: Double{
        let porcentagem = Double(tipPercentage)
        let valorAdicional = checkAmount / 100 * porcentagem
        
        let valorBruto = checkAmount + valorAdicional
        
        return valorBruto
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Número de Pessoas", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) pessoas")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Adicional de Serviço 🤵🏻‍♂️")
                }
                
                Section{
                    Text(totalBruto, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Valor Total 💰")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.title2)
                        .foregroundColor(tipPercentage == 10 ? .blue : .primary)
                } header: {
                    Text("Total por Pessoa 👥")
                }
            }.navigationTitle("Rachador 🍽")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("OK"){
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
