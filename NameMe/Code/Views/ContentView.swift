//
//  ContentView.swift
//  NameMe
//
//  Created by Antonio Vega on 8/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingAddPerson = false
    @State private var addPerson: AddPersonView?
    
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
                            NavigationLink(destination: person.image.resizable().scaledToFit()) {
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
                showingImagePicker = true
            }) {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
        .sheet(isPresented: $showingAddPerson) {
            addPerson
        }
    }
    
    func loadImage() {
        guard let inputImage = self.inputImage else { return }
        addPerson = AddPersonView(uiimage: inputImage, people: people)
        showingAddPerson = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
