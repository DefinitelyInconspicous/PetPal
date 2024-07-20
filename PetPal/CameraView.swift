//
//  CameraView.swift
//  PetPal
//
//  Created by Bryan Nguyen on 20/7/24.
//

import SwiftUI

struct CameraView: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea(.all,edges:.all)
            
            VStack{
                
                Spacer()
                
                HStack{
                    Button(action:{
                        
                    },label:{
                        ZStack{
                            Circle()
                                .fill(Color.white)
                                .frame(width:65, height: 65, alignment: .bottom)
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 75, height: 75)
                                
                        }
                    })
                }
            }
        }
    }
}
class CameraModel: ObservableObject{
    @Published var isTaken = false
}
#Preview {
    CameraView()
}
