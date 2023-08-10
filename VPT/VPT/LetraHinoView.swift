//
//  LetraHinoView.swift
//  VPT
//
//  Created by Biel on 08/08/23.
//

import SwiftUI

struct LetraHinoView: View {
    
    let hino: Hino
    
    var body: some View {
        NavigationStack {
            Text(hino.letra).font(.system(size: 24))
                .padding(.top, 60)
            Spacer()
                .navigationTitle(String(hino.hino))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LetraHinoView_Previews: PreviewProvider {
    static var previews: some View {
        LetraHinoView(hino: Hino.example)
    }
}
