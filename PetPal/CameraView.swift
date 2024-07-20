//
//  CameraView.swift
//  PetPal
//
//  Created by Bryan Nguyen on 20/7/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject var camera = CameraModel()
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea(.all,edges:.all)
            
            VStack{
                if camera.isTaken{
                    HStack{
                        Spacer()
                        Button(action:{}, label:{
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        .padding(.trailing,10)
                    }
                }
                   
                Spacer()
                
                HStack{
                    if camera.isTaken{
                        Button(action:{}, label:{
                            Text("Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                                .padding(.leading)
                        Spacer()
                    }else{
                        Button(action:{
                            camera.isTaken.toggle()
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
                    
                }.frame(height: 75)
            }
        }
    }
}
class CameraModel: ObservableObject{
    @Published var isTaken = false
//    @Published var session = AVCaptureSession()
//    func setUp(){
//        switch AVCaptureDevice.authorizationStatus(for:.video){
//        case.authorized:
//            setUp()
//            return
//        case.notDetermined:
//            AVCaptureDevice.requestAccess(for: .video){ (status) in
//            }
//            
//        case .restricted:
//            <#code#>
//        case .denied:
//            <#code#>
//        @unknown default:
//            <#code#>
//        }
//    }
}
#Preview {
    CameraView()
}
