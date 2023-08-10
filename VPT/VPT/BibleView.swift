//
//  BibleView.swift
//  VPT
//
//  Created by Biel on 23/05/23.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct BibleView: View {
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 330, height: 140)
            RoundedRectangle(cornerRadius: 20)
                .fill(.brown.opacity(0.4))
                .frame(width: 330, height: 140)
            HStack {
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 75, height: 140)
                        .roundedCorner(20, corners: [.topLeft, .bottomLeft])
                    
                    VStack {
                        Text("Dia")
                        Text("1").font(.title2)
                    }.foregroundColor(.white)
                }
                Text("Gn 1-2\nMt 1:1-2:12\nSl 1:1\nPv 1:1-6")
                    .padding()
                    .foregroundColor(.black)
            }
        }
    }
}

struct BibleView_Previews: PreviewProvider {
    static var previews: some View {
        BibleView()
    }
}
