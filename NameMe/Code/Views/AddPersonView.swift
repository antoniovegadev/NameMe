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
    
    var isValidForm: Bool {
        !name.isEmpty && inputImage != nil
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if inputImage == nil {
                    EmptyImageView(width: geo.size.width * 0.4)
                        .onTapGesture {
                            showingImagePicker = true
                        }
                } else {
                    CircleImageView(image: Image(uiImage: inputImage!))
                        .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                        .onTapGesture {
                            showingImagePicker = true
                        }
                }
                
                Form {
                    Section(header: Text("Name")) {
                        TextField("Name", text: $name)
                    }
                }
                
                Button("Save") {
                    add()
                    presentationMode.wrappedValue.dismiss()
                }
                .opacity(isValidForm ? 1.0 : 0.8)
                .allowsHitTesting(isValidForm)
            }
            .padding(.top, 10)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func add() {
        if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
            let newPerson = Person(name: name, jpegData: jpegData)
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
    }
}
