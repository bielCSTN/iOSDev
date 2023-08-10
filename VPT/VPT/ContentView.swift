//
//  ContentView.swift
//  VPT
//
//  Created by Biel on 16/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView2()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            HinarioView()
                .tabItem {
                    Label("Hinário", systemImage: "book.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme(.dark)
    }
}
