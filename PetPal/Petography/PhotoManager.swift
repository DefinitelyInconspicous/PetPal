import SwiftUI

struct Photo: Identifiable, Codable {
    let id: UUID
    let imageData: Data
    let title: String
    let description: String
    let dateTime: String

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
}
class PhotoManager: ObservableObject {
    @Published var photos: [Photo] = []

    func savePhoto(_ photo: Photo) {
        photos.append(photo)
        saveToPersistentStorage()
    }

    func loadPhotos() {
        // Load from persistent storage
        if let data = UserDefaults.standard.data(forKey: "photos") {
            if let savedPhotos = try? JSONDecoder().decode([Photo].self, from: data) {
                photos = savedPhotos
            }
        }
    }

    private func saveToPersistentStorage() {
        if let data = try? JSONEncoder().encode(photos) {
            UserDefaults.standard.set(data, forKey: "photos")
        }
    }
}
