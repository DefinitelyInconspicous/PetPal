//
//  HealthInfoEditScreen.swift
//  PetPal
//
//  Created by Calvin Abad on 17/8/24.
//

import SwiftUI
import Forever

struct HealthInfoEditScreen: View {
    let infoSwitch: Int
    @State var infoToAdd = ""
    @Forever("medInfo") var infoToEdit = PetMedicalConditions(allergies: [], healthIssues: [], medications: [])
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View{
            Form{
                switch infoSwitch{
                case 0:
                    Text("Add Allergy")
                case 1:
                    Text("Add Health Issue")
                case 2:
                    Text("Add Medication")
                default:
                    Text("null")
                }
                TextField("Text", text: $infoToAdd)
                Button("Save"){
                    switch infoSwitch{
                    case 0:
                        infoToEdit.allergies.append(infoToAdd)
                    case 1:
                        infoToEdit.healthIssues.append(infoToAdd)
                    case 2:
                        infoToEdit.medications.append(infoToAdd)
                    default:
                        print("error: out of range")
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }}

#Preview {
    HealthInfoEditScreen(infoSwitch: 1)
}
