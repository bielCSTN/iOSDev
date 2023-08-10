//
//  HomeView.swift
//  VPT
//
//  Created by Biel on 23/05/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Form {
            Section {
                MainMenu()
            }
            
            Section {
                LinksScrollView()
            }
            
            Section {
                VStack(alignment: .leading){
                    Text("Leitura Bíblica de Hoje!")
                        .font(.headline)
                        .padding(.top, 5)
                    BibleView()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().preferredColorScheme(.dark)
    }
}
