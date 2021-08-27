//
//  AddPersonView.swift
//  NameMe
//
//  Created by Antonio Vega on 8/12/21.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var people: People
    
    @State private var name = ""
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var locationOn = false
    @State private var placeMet: CodableMKPointAnnotation? = nil
    
    var isValidForm: Bool {
        !name.isEmpty && inputImage != nil
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Button(action: { showingImagePicker = true }) {
                        if inputImage == nil {
                            EmptyImageView(width: geo.size.width * 0.4)
                        } else {
                            CircleImageView(image: Image(uiImage: inputImage!))
                                .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                        }
                    }

                    Form {
                        Section(header: Text("Name")) {
                            TextField("Name", text: $name)
                        }

                        Section(header: Text("Location")) {
                            NavigationLink(destination: LocationView(placeMet: $placeMet)) {
                                Text(placeMet == nil ? "Add Location" : "Change Location")
                            }
                        }
                    }

                    Button(action: {
                        add()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .padding()
                            .frame(width: 150, height: 50)
                            .background(isValidForm ? Color.blue : Color.gray)
                            .clipShape(Capsule())
                            .allowsHitTesting(isValidForm)
                            .position(x: geo.size.width * 0.5, y: 80)
                    }
                    .buttonStyle(PlainButtonStyle())

                }
                .padding(.top, 10)
            }
            .navigationTitle("Add Person")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func add() {
        if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
            let newPerson = Person(name: name, jpegData: jpegData, placeMet: placeMet)
            people.items.append(newPerson)
            people.saveData()
        } else {
            print("Could not convert UIImage to jpegData.")
        }
    }

    func loadImage() {
        guard let inputImage = self.inputImage else { return }
        self.inputImage = inputImage
    }
}

struct AddPerson_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(people: People())
            .preferredColorScheme(.dark)
    }
}
