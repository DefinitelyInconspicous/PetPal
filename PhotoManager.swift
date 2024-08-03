import SwiftUI

class PhotoManager: ObservableObject {
    @Published var picData: [Data] = [] // Store multiple images
    private let fileManager = FileManager.default
    private let directoryURL: URL

    init() {
        // Define directory URL
        directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Photos")

        // Create directory if it doesn't exist
        if !fileManager.fileExists(atPath: directoryURL.path) {
            do {
                try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory: \(error)")
            }
        }

        // Load existing photos
        loadPhotos()
    }

    func savePhoto(_ data: Data) {
        let fileName = UUID().uuidString + ".jpg"
        let fileURL = directoryURL.appendingPathComponent(fileName)

        do {
            try data.write(to: fileURL)
            picData.append(data) // Update in-memory list
        } catch {
            print("Error saving photo: \(error)")
        }
    }

    func loadPhotos() {
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
            picData = fileURLs.compactMap { try? Data(contentsOf: $0) }
        } catch {
            print("Error loading photos: \(error)")
        }
    }
}
