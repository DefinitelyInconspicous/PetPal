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
    @State private var setWeight = 0
    @State private var setAge = 0
    @State private var setDiet = ""
    @State private var setGender = false
    @State private var birthDate = Date.now
    @State private var setSterile = false
    var body: some View {
        NavigationView{
            VStack{
                List{
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
                    LabeledContent{
                        Stepper("\(setWeight) kg", value: $setWeight, step: 1)
                    }label:{
                        Text("Weight")
                    }
                    LabeledContent{
                        Stepper("\(setAge) years", value: $setAge, step: 1)
                    }label:{
                        Text("Age")
                    }
                    LabeledContent {
                        TextField("Diet", text: $setDiet)
                    } label: {
                        Text("Pet Diet")
                    }
                    LabeledContent{
                        Toggle(setGender ? "Male" : "Female", isOn: $setGender)
                    }label:{
                        Text("Gender")
                    }
                    DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                        Text("Select date of birth")
                    }
                    Toggle("Sterilised", isOn: $setSterile)
                }
            }
        }
        .navigationTitle("Register your pet!")
    }
}

#Preview {
    PetRegistration1View()
}
