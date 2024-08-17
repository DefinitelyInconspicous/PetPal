import SwiftUI

struct PetographyView: View {
    @StateObject private var photoManager = PhotoManager()
    @State private var isCameraActive: Bool = false
    @State private var showlargertitle = false

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
                            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 16) {
                                ForEach(photoManager.photos) { photo in
                                    VStack(alignment: .leading) {
                                        if let image = UIImage(data: photo.imageData) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .onTapGesture {
                                                    showlargertitle = true
                                                }
                                        }
                                        Text(photo.title)
                                            .font(.headline)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                        Text(photo.description)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                            .truncationMode(.tail)
                                        Text("Taken on \(photo.dateTime)")
                                            .font(.caption)
                                    }
                                    .padding()
                                }
                            }
                            .padding()
                }.sheet(isPresented: $showlargertitle, content: {
                    EnlargedView()
                })
                Spacer()
            }
            .onAppear {
                // Load photos when the view appears
                photoManager.loadPhotos()
            }
        }
    }
}
