//
//  PassportView.swift
//  PetPal
//
//  Created by Calvin Abad on 27/7/24.
//

import SwiftUI

func yearsBetweenDate(startDate: Date, endDate: Date) -> Int {

    let calendar = Calendar.current

    let components = calendar.dateComponents([.year], from: startDate, to: endDate)

    return components.year!
}

struct PassportEditView: View {
    @State var setPetName: String
    @State var setPetType: String
    @State var setBreed: String
    @State var setWeight: Double
    //@State  var setAge = 0
    @State var setDiet: String
    @State var setGender: Bool
    @State var setBirthDate: Date
    @State var setSterile: Bool
    @State var age: Int
    var body: some View {
        NavigationView{
            VStack{
                List{
                    LabeledContent {
                        TextField("Name", text: $setPetName)
                    } label: {
                        Text("Pet Name")
                    }
                    LabeledContent {
                        TextField("Type", text: $setPetType)
                    } label: {
                        Text("Pet Type")
                    }
                    LabeledContent {
                        TextField("Breed", text: $setBreed)
                    } label: {
                        Text("Pet Breed")
                    }
                    LabeledContent{
                        Stepper("\(setWeight) kg", value: $setWeight, step: 1)
                    }label:{
                        Text("Weight")
                    }
                        Text("Age: \(age)")
                    LabeledContent {
                        TextField("Diet", text: $setDiet)
                    } label: {
                        Text("Pet Diet")
                    }
                    LabeledContent{
                        Toggle(setGender ? "Male" : "Female", isOn: $setGender)
                    }label:{
                        Text("Gender")
                    }
                    DatePicker(selection: $setBirthDate, in: ...Date.now, displayedComponents: .date) {
                        Text("Select date of birth")
                    }
                    Toggle("Sterilised", isOn: $setSterile)
                    
                    Button{
                        
                    }label:{
                        Text("Save Changes")
                            .background(.blue)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    
                }
            }
        }
        .onAppear(){
            age = yearsBetweenDate(startDate: setBirthDate, endDate: Date())
        }
    }
}

#Preview {
    PassportEditView(setPetName: "n", setPetType: "z", setBreed: "x", setWeight: 20.0, setDiet: "dog meat", setGender: false, setBirthDate: Date(), setSterile: false, age: 10)
}
