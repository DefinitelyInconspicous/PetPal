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
                                
                            } label: {
                                Image(systemName:"plus")
                            }
                        }
                    }
                    Section(header:Text("Health Issues")){
                        ForEach(0..<medInfo.healthIssues.count){healthIssue in
                            Text(medInfo.healthIssues[healthIssue])
                        }
                    }
                    Section(header:Text("Medications")){
                        ForEach(0..<medInfo.medications.count){medication in
                            Text(medInfo.medications[medication])
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    PassportScreen2()
}
