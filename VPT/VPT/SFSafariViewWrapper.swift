//
//  SFSafariViewWrapper.swift
//  TestLink
//
//  Created by Biel on 09/05/23.
//

import SafariServices
import SwiftUI

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    var url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
            return
        }
}
