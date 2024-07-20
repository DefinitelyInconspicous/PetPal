//
//  Home Page.swift
//  PetPal
//
//  Created by Avyan Mehra on 20/7/24.
//

import SwiftUI



struct Home_Page: View {
    var textColour = Color(red: 34, green: 53, blue: 64)
    @State var username = "John"
    
    var body: some View {
        VStack{
            HStack {
                Text("Pet")
                    .font(Font.system(size:60, design: .rounded))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .padding()
                    .foregroundColor(textColour)
                Spacer()
                
                // MARK: - Add Daily Sticker
                
                Text("Pal")
                    .font(Font.system(size:60, design: .rounded))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .padding()
            }
            Rectangle()
                .frame(width: 6000 , height: 4)
            Text("Welcome Back \(username)")
            
            Spacer()
        }
    }
}

#Preview {
    Home_Page()
}












