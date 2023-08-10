//
//  MapView.swift
//  VPT
//
//  Created by Biel on 24/05/23.
//
import MapKit
import SwiftUI

//struct MapMenu: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink {
//                    MapView()
//                } label: {
//                    Text("Brasil")
//                }
//            }.toolbar(.hidden, for: .tabBar)
//                .toolbar(.hidden, for: .navigationBar)
//        }
//    }
//}

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -22.52, longitude: -47.06), span: MKCoordinateSpan(latitudeDelta: 4, longitudeDelta: 4))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.white)
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.uturn.backward.circle")
                            .font(.largeTitle)
                    }
                    .foregroundColor(.white)
                    .background(.black.opacity(0.7))
                    .clipShape(Circle())
                    .padding()
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
