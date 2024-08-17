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
    @State var modifyLists = false
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section(){
                        ForEach(0..<medInfo.allergies.count){allergy in
                            Text(medInfo.allergies[allergy])
                        }
                        .onDelete{indexSet in
                            medInfo.allergies.remove(atOffsets: indexSet)
                                        }
                        .onMove{indices, newOffset in
                            medInfo.allergies.move(fromOffsets: indices, toOffset: newOffset)
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
                        .onDelete{indexSet in
                            medInfo.healthIssues.remove(atOffsets: indexSet)
                                        }
                        .onMove{indices, newOffset in
                            medInfo.healthIssues.move(fromOffsets: indices, toOffset: newOffset)
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
                        .onDelete{indexSet in
                            medInfo.medications.remove(atOffsets: indexSet)
                                        }
                        .onMove{indices, newOffset in
                            medInfo.medications.move(fromOffsets: indices, toOffset: newOffset)
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
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    EditButton()
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
