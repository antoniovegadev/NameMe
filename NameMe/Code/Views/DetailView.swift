//
//  DetailView.swift
//  NameMe
//
//  Created by Antonio Vega on 8/26/21.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let person: Person
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            person.image
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding(.top, 10)

            if person.placeMet != nil {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Photo Location")
                        .font(.headline)

                    DetailMapView(savedLocation: person.location)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                }
                .padding()
            }
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(person: Person.example)
        }
    }
}
