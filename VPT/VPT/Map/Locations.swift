//
//  Locations.swift
//  VPT
//
//  Created by Biel on 25/05/23.
//
import CoreLocation
import Foundation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    
    static let example = Location(name: "Igreja em Jundiaí", coordinate: CLLocationCoordinate2D(latitude: -23.16, longitude: -46.89))
}

let locations = [
    Location(name: "Jundiaí", coordinate: CLLocationCoordinate2D(latitude: -23.165885, longitude: -46.898419)),
    Location(name: "Campinas", coordinate: CLLocationCoordinate2D(latitude: -22.927848, longitude: -47.077652)),
    Location(name: "Ribeirão Preto", coordinate: CLLocationCoordinate2D(latitude: -21.157376, longitude: -47.813664)),
    Location(name: "Sumaré", coordinate: CLLocationCoordinate2D(latitude: -22.821043, longitude: -47.269139)),
    Location(name: "São Paulo", coordinate: CLLocationCoordinate2D(latitude: -23.569731, longitude: -46.716372)),
    Location(name: "Bauru", coordinate: CLLocationCoordinate2D(latitude: -22.318736, longitude: -49.064768)),
    Location(name: "Hortolândia", coordinate: CLLocationCoordinate2D(latitude: -22.880903, longitude: -47.205352)),
    Location(name: "Limeira", coordinate: CLLocationCoordinate2D(latitude: -22.557904, longitude: -47.406852)),
    Location(name: "São Carlos", coordinate: CLLocationCoordinate2D(latitude: -22.026914, longitude: -47.885595)),
    Location(name: "S.J. Rio Preto", coordinate: CLLocationCoordinate2D(latitude: -20.803259, longitude: -49.382450)),
    Location(name: "Várzea Paulista", coordinate: CLLocationCoordinate2D(latitude: -23.198830, longitude: -46.819119))
]
