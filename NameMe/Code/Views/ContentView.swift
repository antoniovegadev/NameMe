//
//  ContentView.swift
//  NameMe
//
//  Created by Antonio Vega on 8/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddPerson = false
    @ObservedObject var people = People()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 50) {
                        ForEach(people.items.sorted()) { person in
                            NavigationLink(destination: DetailView(person: person)) {
                                VStack {
                                    CircleImageView(image: person.image)
                                        .padding()
                                    
                                    Text(person.name)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(20)
            }
            .navigationTitle("NameMe")
            .navigationBarItems(trailing: Button(action: {
                showingAddPerson = true
            }) {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingAddPerson) {
            AddPersonView(people: people)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
