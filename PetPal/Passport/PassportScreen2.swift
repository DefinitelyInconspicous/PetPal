//
//  PassportScreen2.swift
//  PetPal
//
//  Created by Calvin Abad on 27/7/24.
//

import SwiftUI

struct PassportScreen2: View {
    @State var medInfo = PetMedicalConditions(allergies: ["Chocolate"], healthIssues: ["Obesity"], medications: ["Opium"])
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section{
                        ForEach(0..<medInfo.allergies.count){allergy in
                            Text(medInfo.allergies[allergy])
                        }
                    }
                    Section{
                        ForEach(0..<medInfo.healthIssues.count){healthIssue in
                            Text(medInfo.healthIssues[healthIssue])
                        }
                    }
                    Section{
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
