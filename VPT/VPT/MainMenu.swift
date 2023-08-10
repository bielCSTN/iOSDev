//
//  MainMenu.swift
//  VPT
//
//  Created by Biel on 16/05/23.
//

import SwiftUI

struct MainMenu: View {
    
    @State private var showingView = false
    
    let data = ["locais", "news", "eventos", "series", "tutorial", "cursos", "editora", "pp"]
    
    let symbols = [
        "locais" : "mappin",
        "news" : "newspaper.fill",
        "eventos" : "calendar",
        "series" : "play.fill",
        "tutorial" : "video.fill",
        "cursos" : "graduationcap.fill",
        "editora" : "books.vertical.fill",
        "pp" : "book.fill"
    ]
    
    let labels = [
        "locais" : "Locais",
        "news" : "Notícias",
        "eventos" : "Eventos",
        "series" : "Séries",
        "tutorial" : "Eventos",
        "cursos" : "Cursos",
        "editora" : "Editora",
        "pp" : "Palavra"
    ]

        let columns = [
            GridItem(.adaptive(minimum: 80))
        ]
    
    private var fourColumns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
            LazyVGrid(columns: fourColumns, spacing: 25) {
                ForEach(data, id: \.self) { item in
                    VStack {
                        Button {
                            if item == data[0] {
                                showingView = true
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 44, height: 44)
                                
                                Image(systemName: symbols[item]!)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Text(labels[item]!)
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showingView) {
                MapView()
            }
    }
    
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
