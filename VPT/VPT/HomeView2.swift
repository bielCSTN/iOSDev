//
//  HomeView2.swift
//  VPT
//
//  Created by Biel on 23/05/23.
//

import SwiftUI

struct HomeView2: View {
    @Environment(\.colorScheme) var colorScheme
    

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.085).ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    ZStack {
                        Rectangle()
                            .fill(colorScheme == .dark ? .black : .white)
                            .frame(width: nil, height: 240)
                            .opacity(0)
                        
                        Image(decorative: colorScheme == .light ? "ivptlogo" : "ivptlogowhite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 140)
                            .padding(.top, -195)
                    }.padding(.bottom, -155)
                    
                    
                    ZStack {
                        Rectangle()
                            .fill(colorScheme == .dark ? .black : .white)
                            .frame(width: nil, height: 240)
                        
                        MainMenu()
                    }.padding(.bottom, 15)
                    
                    ZStack {
                        Rectangle()
                            .fill(colorScheme == .dark ? .black : .white)
                            .frame(width: nil, height: 120)
                        
                        LinksScrollView()
                            .padding()
                    }.padding(.bottom, 15)
                    
                    ZStack {
                        Rectangle()
                            .fill(colorScheme == .dark ? .black : .white)
                            .frame(width: nil, height: 200)
                        VStack(alignment: .leading){
                            Text("Leitura Bíblica de Hoje!").font(.headline)
                            BibleView()
                        }
                    }.padding(.bottom, 15)
                }
            }
            .toolbar(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2()
    }
}
