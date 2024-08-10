import SwiftUI

struct PhotoDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var photoManager: PhotoManager
    var photoData: Data

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var dateTime: String = ""

    var body: some View {
        VStack {
            if let image = UIImage(data: photoData) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding()
            }

            Text("Date & Time: \(dateTime)")
                .padding()

            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Save") {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateTime = dateFormatter.string(from: Date())

                let photo = Photo(id: UUID(), imageData: photoData, title: title, description: description, dateTime: dateTime)
                photoManager.savePhoto(photo)
                
                dismissToPetography()
            }
            .padding()

            Spacer()
        }
        .onAppear {
            // Set the date and time when the view appears
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateTime = dateFormatter.string(from: Date())
        }
    }

    private func dismissToPetography() {
        DispatchQueue.main.async {
            dismiss() // Dismiss the PhotoDetailView
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
