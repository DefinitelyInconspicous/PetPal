//
//  Home Page.swift
//  PetPal
//
//  Created by Avyan Mehra on 20/7/24.
//

import SwiftUI
import Charts

struct weightCell {
    var weight: Int
    var date: Int
}
struct Home_Page: View {
    var textColour = Color(red: 34 / 255, green: 53 / 255, blue: 64 / 255)
    var rectColour = Color(red: 242/255, green: 241/255, blue: 216/255)
    @State var username = "John"
     var weightGraph = [20,23,18,28,32,14,29,45,49,34,46,29,19,20,28,38,41,49,46,54,61]
    @State var timeGraph = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]
    @State var weightData: [weightCell]
    @State var weightCount = 0
    
    var body: some View {
        ForEach(weightGraph, id: \.self) { weightVal in
            weightData.append(weightCell(weight: weightVal, date: timeGraph[weightGraph.firstIndex(of: weightVal) ?? 0]))
            weightCount += 1
        }
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
                    .foregroundColor(textColour)
            }
            Rectangle()
                .frame(width: 6000 , height: 4)
                .foregroundColor(textColour)
            Text("Welcome Back \(username)!")
                .font(.title2)
                .fontWeight(.medium)
            ZStack {
                Rectangle()
                    .frame(width: 350, height: 170)
                    .cornerRadius(20)
                    .foregroundColor(rectColour)
                VStack {
                 Text("Your Pet's Weight over the Months")
                        .font(.headline)
                    Chart {
                        ForEach(weightGraph, id: \.self ) { weightVal in
                           
                            LineMark(x: .value("Date", timeGraph[weightCount]), y: weightData[weightCount])
                            
                            
                        }
                    }
                }
                
            }
            Spacer()
            
        }
    }
}

#Preview {
    Home_Page(weightData: [weightCell(weight: 0, date: 0)])
}












