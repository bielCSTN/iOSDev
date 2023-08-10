//
//  HinarioView.swift
//  VPT
//
//  Created by Biel on 08/08/23.
//

import SwiftUI

struct HinarioView: View {
    
    let hinos: [Hino] = Bundle.main.decode("hinos.json")
    
    let rows = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [0]
    ]
    
    let rows2 = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "ESC"]
    ]
    
    let hinarios = ["S", "H", "C"]
    @State private var selectedHinario = "H"
    
    @State private var hymn = ""
    
    @State private var selectedHino = -1
    
    @State private var displayedHymn: Hino?
    
    @State private var showLyricSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text(selectedHinario + "-" + hymn)
                    .font(.system(size: 44))
                    .multilineTextAlignment(.center)
                
                Button("Buscar Hino") {
                    if let hymnNumber = Int(hymn), let hymn = hinos.first(where: {$0.hino == hymnNumber}) {
                        displayedHymn = hymn
                    }
                    showLyricSheet = true
                }.padding(-5)
                
                
                Picker("hino", selection: $selectedHinario) {
                    ForEach(hinarios, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(40)
                .padding(.bottom, -20)
                
                VStack(spacing: 10) {
                    ForEach(rows2, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(row, id: \.self) { number in
                                Button(action: {
                                    if number != "ESC" {
                                        hymn += "\(number)"
                                    } else {
                                        hymn = ""
                                    }
                                }) {
                                    if number != "ESC" {
                                        Text("\(number)")
                                            .font(.title)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.primary)
                                            .overlay(
                                                Circle()
                                                    .stroke(.black, lineWidth: 3)
                                            )
                                    } else {
                                        Image(systemName: "delete.left")
                                            .font(.title)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showLyricSheet) {
                if let displayedHymn = displayedHymn {
                    LetraHinoView(hino: displayedHymn)
                }
            }
        }
    }
    
//    func buscarHino() {
//        if hinos.contains(where: hymn) {
//            LetraHinoView(hino: )
//        }
//    }
  
}

struct HinarioView_Previews: PreviewProvider {
    static var previews: some View {
        HinarioView()
    }
}
