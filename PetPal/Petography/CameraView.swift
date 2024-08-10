//
//  CameraView.swift
//  PetPal
//
//  Created by Bryan Nguyen on 20/7/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var camera: CameraModel
    @ObservedObject var photoManager: PhotoManager
    @Binding var isActive: Bool
    @State private var showPhotoDetail = false

    var body: some View {
        ZStack {
            if camera.isTaken {
                if let image = UIImage(data: camera.picData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            camera.reTake() // Reset the camera for retaking a photo
                        }, label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        .padding(.trailing, 10)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            // Show PhotoDetailView
                            showPhotoDetail = true
                        }, label: {
                            Text("Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        
                        Spacer()
                    }
                    .background(
                        NavigationLink(
                            destination: PhotoDetailView(photoManager: photoManager, photoData: camera.picData),
                            isActive: $showPhotoDetail
                        ) {
                            EmptyView()
                        }
                    )
                }
            } else {
                CameraPreview(camera: camera)
                    .ignoresSafeArea(.all, edges: .all)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            camera.takePic() // Take a picture
                        }, label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65, alignment: .bottom)
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                    .frame(height: 75)
                }
            }
        }
        .onChange(of: camera.isSaved) { isSaved in
            if isSaved {
                dismissToRoot()
            }
        }
    }

    private func dismissToRoot() {
        DispatchQueue.main.async {
            dismiss() // Dismiss the CameraView
            if let navigationController = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow })?
                .rootViewController as? UINavigationController {
                navigationController.popToRootViewController(animated: false)
            }
        }
    }
}
    class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
        @Published var isTaken = false
        @Published var session = AVCaptureSession()
        @Published var alert = false
        @Published var output  = AVCapturePhotoOutput()
        @Published var preview: AVCaptureVideoPreviewLayer!
        @Published var isSaved = false
        @Published var picData = Data()
        @Published var savedImage: UIImage?
        
        override init() {
            super.init()
            DispatchQueue.global(qos: .background).async {
                self.setUp()
            }
        }
        
        func Check() {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                setUp()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { status in
                    if status {
                        DispatchQueue.main.async {
                            self.setUp()
                        }
                    }
                }
            case .denied:
                DispatchQueue.main.async {
                    self.alert.toggle()
                }
            default:
                break
            }
        }
        
        func setUp() {
            DispatchQueue.global(qos: .background).async {
                do {
                    self.session.beginConfiguration()
                    
                    let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
                    if let device = device {
                        let input = try AVCaptureDeviceInput(device: device)
                        if self.session.canAddInput(input) {
                            self.session.addInput(input)
                        }
                        if self.session.canAddOutput(self.output) {
                            self.session.addOutput(self.output)
                        }
                    }
                    
                    self.session.commitConfiguration()
                    
                    DispatchQueue.main.async {
                        self.session.startRunning()
                    }
                } catch {
                    print("Error setting up camera: \(error.localizedDescription)")
                }
            }
        }
        
        func takePic() {
            DispatchQueue.global(qos: .background).async {
                guard self.session.isRunning else {
                    print("Session is not running")
                    return
                }
                
                let settings = AVCapturePhotoSettings()
                self.output.capturePhoto(with: settings, delegate: self)
            }
        }
        
        func reTake() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.session.startRunning()
                }
                
                DispatchQueue.main.async {
                    withAnimation { self.isTaken = false }
                    self.isSaved = false
                }
            }
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                print("Error capturing photo: \(error.localizedDescription)")
                return
            }
            
            guard let imageData = photo.fileDataRepresentation() else {
                print("Failed to get image data representation")
                return
            }
            
            DispatchQueue.main.async {
                self.picData = imageData
                self.isTaken = true
            }
        }
        
        func savePic() {
            DispatchQueue.global(qos: .background).async {
                if !self.picData.isEmpty, let image = UIImage(data: self.picData) {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    DispatchQueue.main.async {
                        self.savedImage = image
                        self.isSaved = true
                    }
                } else {
                    print("No image data available to save.")
                }
            }
        }
    }
    
    
    struct CameraPreview: UIViewRepresentable {
        @ObservedObject var camera: CameraModel
        
        func makeUIView(context: Context) -> UIView {
            let view = UIView(frame: UIScreen.main.bounds)
            view.backgroundColor = .black // Ensure the background is black for a cleaner look
            
            // Setup camera preview
            camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
            camera.preview.frame = view.bounds
            camera.preview.videoGravity = .resizeAspectFill
            view.layer.addSublayer(camera.preview)
            
            // Start the camera session
            camera.session.startRunning()
            
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            if camera.isTaken {
                // Remove all existing layers
                uiView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
                
                // Display the captured photo
                if !camera.picData.isEmpty, let image = UIImage(data: camera.picData) {
                    let imageView = UIImageView(frame: uiView.bounds)
                    imageView.image = image
                    imageView.contentMode = .scaleAspectFill
                    uiView.addSubview(imageView)
                }
            } else {
                // Re-add the camera preview layer if no photo is taken
                if camera.preview.superlayer == nil {
                    camera.preview.frame = uiView.bounds
                    uiView.layer.addSublayer(camera.preview)
                }
            }
        }
    }

