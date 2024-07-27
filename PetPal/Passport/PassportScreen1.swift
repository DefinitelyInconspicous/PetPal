//
//  PassportScreen1.swift
//  PetPal
//
//  Created by Calvin Abad on 27/7/24.
//

import SwiftUI

struct PassportScreen1: View {
    @State var petName = ""
    @State var petType = ""
    @State var breed = ""
    @State var weight = 0
    //@State  var setAge = 0
    @State var diet = ""
    @State var gender: Gender = .male
    @State var birthDate = Date.now
    @State var sterile = false
    @State var age = 0
    @State var displayEditPage1 = false
    enum Gender: String, CaseIterable, Identifiable {
        case male, female, nonbinary
        var id: Self { self }
    }
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Text("Name: \(petName)")
                    Text("Pet Type: \(petType)")
                    Text("Pet Breed: \( breed)")
                    Text("Weight: \(weight)")
                    Text("Diet: \(diet)")
                    Text("Gender: \(gender)")
                    Text("Date of Birth: \(birthDate)")
                    Text("Sterile: \(sterile ? "Yes" : "No")")
                    Text("Age: \(age)")
                }
            }
            .navigationTitle("Pet Passport")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        displayEditPage1 = true
                    }label:{
                        Image(systemName: "pencil")
                    }
                }
            }
            .onAppear(){
                age = yearsBetweenDate(startDate: birthDate, endDate: Date())
            }
        }
    }
}
#Preview {
    PassportScreen1()
}
