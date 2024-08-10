import SwiftUI

struct PetographyView: View {
    @StateObject private var photoManager = PhotoManager()
    @State private var isCameraActive: Bool = false
    @StateObject private var camera = CameraModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Petography")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading) // Padding on the left side
                    
                    Spacer() // Pushes the button to the far right
                    
                    NavigationLink(
                        destination: CameraView(camera: camera, photoManager: photoManager, isActive: $isCameraActive),
                        isActive: $isCameraActive
                    ) {
                        Image(systemName: "camera.fill")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .padding(.trailing) // Padding on the right side
                }
                .padding([.top, .horizontal]) // Add padding around the HStack

                Text("Record memories with your pets here, and reminisce the valuable ones with them!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                ScrollView {
                    VStack {
                        ForEach(photoManager.picData, id: \.self) { data in
                            if let image = UIImage(data: data)?.resized(to: CGSize(width: 200, height: 200)) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 200, height: 200)
                                    .padding()
                            }
                        }
                    }
                }
                
                Spacer() // Pushes the content up
            }
            .onAppear {
                photoManager.loadPhotos() // Ensure the photoManager picData is updated when the view appears
            }
        }
    }
}
