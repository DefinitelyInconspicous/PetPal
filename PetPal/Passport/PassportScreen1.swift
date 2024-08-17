//
//  PassportScreen1.swift
//  PetPal
//
//  Created by Calvin Abad on 27/7/24.
//
import SwiftUI
import Forever
struct PassportScreen1: View {
    @Forever("pet") var pet = Pet(petName: "Rufus", petType: "Dog", breed: "Golden Retriever", weight: 10.0, diet: "Omnivorous", gender: .male, birthDate: Date.now, sterile: false, age: 0)
    @State var displayEditPage1 = false
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Text("Name: \(pet.petName)")
                    Text("Pet Type: \(pet.petType)")
                    Text("Pet Breed: \(pet.breed)")
                    Text("Weight: \(pet.weight)kg")
                    Text("Diet: \(pet.diet)")
                    Text("Gender: \(pet.gender)")
                    Text("Date of Birth: \(pet.birthDate)")
                    Text("Sterile: \(pet.sterile ? "Yes" : "No")")
                    Text("Age: \(pet.age)")
                }
                NavigationLink{
                    PassportScreen2()
                }label:{
                    Text("View Health Info")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .buttonStyle(BorderedButtonStyle())
                        .cornerRadius(10)
                        .frame(width: 200, height: 100)
                }
            }
            .navigationTitle("Pet Passport")
            
            .onAppear(){
                pet.age = yearsBetweenDate(startDate: pet.birthDate, endDate: Date())
            }
            .sheet(isPresented: $displayEditPage1){ PassportEditView()
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button{
                    displayEditPage1 = true
                }label:{
                    Image(systemName: "pencil")
                }
            }
        }
    }
}
#Preview {
    PassportScreen1()
}
