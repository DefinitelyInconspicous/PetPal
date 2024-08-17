//
//  PassportScreen2.swift
//  PetPal
//
//  Created by Calvin Abad on 27/7/24.
//

import SwiftUI
import Forever
struct PassportScreen2: View {
    @Forever("medInfo") var medInfo = PetMedicalConditions(allergies: ["Peanuts"], healthIssues: ["Obesity"], medications: ["Panadol"])
    @State var editToggle = false
    @State var editCategory = 0
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section(){
                        ForEach(0..<medInfo.allergies.count){allergy in
                            Text(medInfo.allergies[allergy])
                        }
                        
                    } header: {
                        HStack {
                            Text("Allergies")
                            Spacer()
                            Button {
                                editCategory = 0
                                editToggle = true
                                
                            } label: {
                                Image(systemName:"plus")
                            }
                        }
                    }
                    Section(){
                        ForEach(0..<medInfo.healthIssues.count){healthIssue in
                            Text(medInfo.healthIssues[healthIssue])
                        }
                    } header: {
                        HStack {
                            Text("Health Issues")
                            Spacer()
                            Button {
                                editCategory = 1
                                editToggle = true
                            } label: {
                                Image(systemName:"plus")
                            }
                        }
                    }
                    Section(){
                        ForEach(0..<medInfo.medications.count){medication in
                            Text(medInfo.medications[medication])
                        }
                    } header: {
                        HStack {
                            Text("Medications")
                            Spacer()
                            Button {
                                editCategory = 2
                                editToggle = true
                            } label: {
                                Image(systemName:"plus")
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $editToggle){
            HealthInfoEditScreen(infoSwitch: editCategory)
        }
    }
}
#Preview {
    PassportScreen2()
}
