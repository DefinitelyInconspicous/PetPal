//
//  PassportView.swift
//  PetPal
//
//  Created by Calvin Abad on 27/7/24.
//

import SwiftUI
import Forever

struct data: Decodable, Encodable {
    var weigh: Double
    var time: Int
}

struct PassportEditView: View {
//    @Binding var setPetName: String
//    @Binding var setPetType: String
//    @Binding var setBreed: String
//    @Binding var setWeight: Double
//    @Binding var setDiet: String
//    @Binding var setGender: Gender
//    @Binding var setBirthDate: Date
//    @Binding var setSterile: Bool
//    @Binding var age: Int
    
    @Forever("pet") var pet = Pet(petName: "", petType: "", breed: "", weight: 0.0, diet: "", gender: .male, birthDate: Date.now, sterile: false, age: 0)
    @Forever("weightg") var weightg: [data] = []
    @State var time = 0
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            VStack{
                List{
                    LabeledContent {
                        TextField("Name", text: $pet.petName)
                    } label: {
                        Text("Pet Name:")
                    }
                    LabeledContent {
                        TextField("Type", text: $pet.petType)
                    } label: {
                        Text("Pet Type:")
                    }
                    LabeledContent {
                        TextField("Breed", text: $pet.breed)
                    } label: {
                        Text("Pet Breed:")
                    }
                    LabeledContent{
                        Stepper("\(pet.weight) kg", value: $pet.weight, step: 0.5)
                            .onChange(of: pet.weight) { _ in
                                weightg.append(data(weigh: pet.weight, time: time+1))
                                time += 1
                            }
                    }label:{
                        Text("Weight:")
                    }
                    Text("Age: \(pet.age)")
                    
                    LabeledContent {
                        TextField("Diet", text: $pet.diet)
                    } label: {
                        Text("Pet Diet:")
                    }
                    Picker(selection: $pet.gender, label: Text("Gender")){
                        Text("Male").tag(Gender.male)
                        Text("Female").tag(Gender.female)
                    }
                    DatePicker(selection: $pet.birthDate, in: ...Date.now, displayedComponents: .date) {
                        Text("Select date of birth")
                    }
                    Toggle("Sterilised", isOn: $pet.sterile)
                    
                    
                    }
                Button{
                    presentationMode.wrappedValue
                        .dismiss()
                    weightg.append(data(weigh: pet.weight, time: weightg.count+1))
                }label:{
                    Text("Save Changes")
                        .foregroundStyle(.blue)
                        .padding()
                }
            }
        }
        .onAppear(){
            pet.age = yearsBetweenDate(startDate: pet.birthDate, endDate: Date())
        }
    }
}

#Preview {
    PassportEditView()
}
