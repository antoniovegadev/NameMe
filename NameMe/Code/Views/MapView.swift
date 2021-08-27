//
//  MapView.swift
//  BucketList
//
//  Created by Antonio Vega on 8/10/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var currentLocation: CLLocationCoordinate2D?
    var withAnnotation: MKPointAnnotation?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = false
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let currentLocation = self.currentLocation {
            print("Location ON: \(currentLocation)")
            uiView.removeAnnotations(uiView.annotations)
            if let annotation = self.withAnnotation {
                uiView.removeAnnotation(annotation)
            }
            uiView.showsUserLocation = true
            let region = MKCoordinateRegion(
                center: currentLocation,
                latitudinalMeters: 800,
                longitudinalMeters: 800
            )
            uiView.setRegion(region, animated: true)
        } else if let annotation = self.withAnnotation {
            print("Location OFF")
            uiView.showsUserLocation = false
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(annotation)
        } else {
            print("Neither")
            uiView.showsUserLocation = false
            uiView.removeAnnotations(uiView.annotations)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
            currentLocation: CLLocationCoordinate2D(),
            withAnnotation: MKPointAnnotation.example
        )
        .edgesIgnoringSafeArea(.all)
    }
}
