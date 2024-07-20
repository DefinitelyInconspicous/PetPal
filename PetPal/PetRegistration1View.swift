//
//  PetRegistration1View.swift
//  PetPal
//
//  Created by Calvin Abad on 20/7/24.
//

import SwiftUI

struct PetRegistration1View: View {
    @State private var setPetName = ""
    @State private var setPetType = ""
    @State private var setBreed = ""
    var body: some View {
        NavigationView{
            VStack{
                LabeledContent {
                  TextField("Name", text: $setPetName)
                } label: {
                  Text("Pet Name")
                }
                LabeledContent {
                  TextField("Type", text: $setPetType)
                } label: {
                  Text("Pet Type")
                }
                LabeledContent {
                  TextField("Breed", text: $setBreed)
                } label: {
                  Text("Pet Breed")
                }
            }
        }
        .navigationTitle("Register your pet!")
    }
}

#Preview {
    PetRegistration1View()
}
