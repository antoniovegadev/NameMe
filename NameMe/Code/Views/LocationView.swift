//
//  LocationView.swift
//  BucketList
//
//  Created by Antonio Vega on 8/11/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationView: View {
    @Binding var placeMet: CodableMKPointAnnotation?

    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var currentLocation: CLLocationCoordinate2D?
    @State private var annotation: CodableMKPointAnnotation?
    
    @State private var locationOn = false

    let locationFetcher = LocationFetcher()

    var addPinButton: some View {
        Button(action: {
            if !locationOn {
                let newLocation = CodableMKPointAnnotation()
                newLocation.coordinate = centerCoordinate
                annotation = newLocation
                placeMet = newLocation
                locationFetcher.start()
            }
        }) {
            Image(systemName: "plus")
        }
        .padding()
        .background(Color.black.opacity(0.75))
        .foregroundColor(.white)
        .font(.title)
        .clipShape(Circle())
        .padding(.trailing)
    }

    var currentLocationButton: some View {
        Button(action: {
            withAnimation {
                locationOn = true
            }

            if let location = locationFetcher.lastKnownLocation {
                currentLocation = location
                let newAnnotation = CodableMKPointAnnotation()
                newAnnotation.coordinate = location
                placeMet = newAnnotation
                print("Your location is \(location).")
            } else {
                print("Your location is unknown.")
            }
        }) {
            Image(systemName: "location.north.fill")
                .rotationEffect(locationOn ? .zero : .degrees(45))
        }
        .padding()
        .background(locationOn ? Color.green : Color.blue)
        .foregroundColor(.white)
        .font(.title2)
        .clipShape(Circle())
        .padding(.trailing)
        .allowsHitTesting(!locationOn)
    }
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, currentLocation: currentLocation, withAnnotation: annotation)
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: locationFetcher.start)

            if !locationOn {
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        currentLocationButton
                        if !locationOn {
                            addPinButton
                                .transition(.scale)
                        }
                    }
                }
            }
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(placeMet: .constant(CodableMKPointAnnotation()))
    }
}
