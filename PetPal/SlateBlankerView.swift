//
//  SlateBlankerView.swift
//  PetPal
//
//  Created by Calvin Abad on 24/8/24.
//

import SwiftUI
import Forever
struct SlateBlankerView: View {
    @Forever("pet") var pet = Pet(petName: "Rufus", petType: "Dog", breed: "Golden Retriever", weight: 10.0, diet: "Omnivorous", gender: .male, birthDate: Date.now, sterile: false, age: 0)
    @Forever("weightg") var weightG: [data] = []
    @Forever("medInfo") var medInfo = PetMedicalConditions(allergies: [], healthIssues: [], medications: [])
    var body: some View {
        NavigationView{
            VStack{
                Text("This will reset all data. Continue?")
                Button{
                    print("The slate has been blanked")
                    pet = Pet(petName: "", petType: "", breed: "", weight: 0.0, diet: "", gender: .male, birthDate: Date.now, sterile: false, age: 0)
                    weightG = []
                    medInfo = PetMedicalConditions(allergies: [], healthIssues: [], medications: [])
                }label:{
                    Text("CONFIRM")
                }
                .padding()
                .background(Color.red)
                .foregroundStyle(Color.white)
            }
        }
    }
}

#Preview {
    SlateBlankerView()
}
