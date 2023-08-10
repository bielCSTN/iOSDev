//
//  LinksScrollView.swift
//  VPT
//
//  Created by Biel on 23/05/23.
//

import SafariServices
import SwiftUI

struct Link: Hashable {
    let name: String
    let image: String
    var url: String
}

struct LinksScrollView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showLink = false
    
    let links = [Link(name: "imersao", image: "banner-imersao", url: "http://oquetemosvistoeouvido.com.br"), Link(name: "fvk", image: "banner-fvk", url: "http://institutovidaparatodos.org.br/editoriais/noticias/fabrica-de-vencedores-kids/"), Link(name: "missoes", image: "banner-missoes", url: "http://institutovidaparatodos.org.br/editoriais/noticias/missoes-no-esterior/"), Link(name: "288", image: "banner-288", url: "https://288oficial.com/"), Link(name: "expolivro", image: "banner-expo", url: "https://expolivro.com.br/")]
    
    let urls: [URL] = [
        URL(string: "https://www.example.com")!,
        URL(string: "https://www.apple.com")!,
        URL(string: "https://www.google.com")!
    ]
    
    @State private var selectedURL: URL?
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15){
                    ForEach(links, id: \.self) { link in
                        ZStack {
                            Image(link.image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .frame(width: 240)
                                .overlay {
                                    if colorScheme == .dark {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.white, lineWidth: 0.75)
                                    }
                                }
                        }
                        .onTapGesture {
                            selectedURL = URL(string: link.url)!
                            showLink = true
                        }
            
                        .sheet(isPresented: $showLink) {
                            if let selectedURL = selectedURL {
                                SFSafariViewWrapper(url: selectedURL)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct LinksScrollView_Previews: PreviewProvider {
    static var previews: some View {
        LinksScrollView()
    }
}
