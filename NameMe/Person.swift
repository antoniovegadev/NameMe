//
//  Person.swift
//  NameMe
//
//  Created by Antonio Vega on 8/12/21.
//

import SwiftUI

class People: ObservableObject {
    @Published var items = [Person]()
    
    init() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPeople")
        
        if let data = try? Data(contentsOf: filename) {
            if let decoded = try? JSONDecoder().decode([Person].self, from: data) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPeople")
            let data = try JSONEncoder().encode(items)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

struct Person: Codable, Identifiable, Comparable {
    var id = UUID()
    let name: String
    let jpegData: Data
    
    var image: Image {
        guard let uiImage = UIImage(data: jpegData) else { return Image(systemName: "person.crop.fill") }
        return Image(uiImage: uiImage)
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
}
