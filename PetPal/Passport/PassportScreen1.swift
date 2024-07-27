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
    @State var gender = false
    @State var birthDate = Date.now
    @State var sterile = false
    @State var age = 0
    var body: some View {
        NavigationView{
            VStack{
                List{
                    LabeledContent {
                    } label: {
                        Text("Pet Name")
                    }
                    LabeledContent
                    } label: {
                        Text("Pet Type")
                    }
                    LabeledContent {
                        
                    } label: {
                        Text("Pet Breed")
                    }
                    LabeledContent{
                    
                    }label:{
                        Text("Weight")
                    }
                        Text("Age: \(age)")
                    LabeledContent {
                        
                    } label: {
                        Text("Pet Diet")
                    }
                    LabeledContent{
                        
                    }label:{
                        Text("Gender")
                    }
                    
                  
                }
            }
        }
        .navigationTitle("Pet Passport")
        .onAppear(){
            age = yearsBetweenDate(startDate: birthDate, endDate: Date())
        }
    }
}

#Preview {
    PassportScreen1()
}
