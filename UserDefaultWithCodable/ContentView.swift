//
//  ContentView.swift
//  UserDefaultWithCodable
//
//  Created by Ramill Ibragimov on 01.08.2020.
//

import SwiftUI

struct User: Codable {
    let firstName: String
    let secondName: String
}

struct ContentView: View {
    @State private var firstName = ""
    @State private var secondName = ""
    
    @State private var defaultUser = User(firstName: "John", secondName: "Doe")
    
    @State private var userDefaultsFirstName = ""
    @State private var userDefaultsSecondName = ""
    
    var body: some View {
        VStack {
            Group {
                if !userDefaultsFirstName.isEmpty && !userDefaultsSecondName.isEmpty {
                    Text("Saved user: \(userDefaultsFirstName) \(userDefaultsSecondName)")
                        .padding()
                }
            }
            Group {
                TextField("First name", text: $firstName)
                TextField("Second name", text: $secondName)
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save user data") {
                if !firstName.isEmpty && !secondName.isEmpty {
                    defaultUser = User(firstName: firstName, secondName: secondName)
                    if let data = try? JSONEncoder().encode(self.defaultUser) {
                        UserDefaults.standard.set(data, forKey: "userData")
                    }
                } else {
                    if let data = try? JSONEncoder().encode(self.defaultUser) {
                        UserDefaults.standard.set(data, forKey: "userData")
                    }
                }
                if let dataFromUserDefailts = UserDefaults.standard.data(forKey: "userData") {
                    if let decodedData = try? JSONDecoder().decode(User.self, from: dataFromUserDefailts) {
                        userDefaultsFirstName = decodedData.firstName
                        userDefaultsSecondName = decodedData.secondName
                    }
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
