import SwiftUI

struct PetographyView: View {
    @StateObject private var photoManager = PhotoManager()
    @State private var isCameraActive: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Petography")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading)
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: CameraView(camera: CameraModel(), photoManager: photoManager, isActive: $isCameraActive),
                        isActive: $isCameraActive
                    ) {
                        Image(systemName: "camera.fill")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .padding(.trailing)
                }
                .padding([.top, .horizontal])

                Text("Record memories with your pets here, and reminisce the valuable ones with them!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)

                ScrollView {
                    ForEach(photoManager.photos) { photo in
                        VStack(alignment: .leading) {
                            if let image = UIImage(data: photo.imageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                            }
                            Text(photo.title)
                                .font(.headline)
                            Text(photo.description)
                                .font(.subheadline)
                            Text("Taken on \(photo.dateTime)")
                                .font(.caption)
                        }
                        .padding()
                    }
                }

                Spacer()
            }
            .onAppear {
                // Load photos when the view appears
                photoManager.loadPhotos()
            }
        }
    }
}
