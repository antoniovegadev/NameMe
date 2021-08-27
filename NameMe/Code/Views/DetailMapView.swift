//
//  DetailMapView.swift
//  NameMe
//
//  Created by Antonio Vega on 8/26/21.
//

import SwiftUI
import MapKit

struct DetailMapView: UIViewRepresentable {
    var savedLocation: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = savedLocation
        uiView.addAnnotation(annotation)
        uiView.setCenter(savedLocation, animated: true)
    }
}

struct DetailMapView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMapView(savedLocation: Person.example.placeMet!.coordinate)
    }
}
