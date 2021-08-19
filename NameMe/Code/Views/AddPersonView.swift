//
//  AddPersonView.swift
//  NameMe
//
//  Created by Antonio Vega on 8/12/21.
//

import SwiftUI

struct AddPersonView: View {
    var uiimage: UIImage
    @State private var name = ""
    @ObservedObject var people: People
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    Spacer()
                    
                    CircleImageView(image: Image(uiImage: uiimage))
                        .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                    
                    Form {
                        TextField("Name", text: $name)
                    }
                    
                    Spacer()
                    
                }
                .navigationTitle("Add new person")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Save") {
                    add()
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
    
    func add() {
        if let jpegData = uiimage.jpegData(compressionQuality: 0.8) {
            let newPerson = Person(name: name, jpegData: jpegData)
            people.items.append(newPerson)
            people.saveData()
        } else {
            print("Could not convert UIImage to jpegData.")
        }
        
    }
    
}

struct AddPerson_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(uiimage: UIImage(systemName: "person.crop.circle")!, people: People())
    }
}
