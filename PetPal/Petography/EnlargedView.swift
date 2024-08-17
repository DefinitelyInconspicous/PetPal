//
//  EnlargedView.swift
//  PetPal
//
//  Created by Bryan Nguyen on 17/8/24.
//

import SwiftUI

struct EnlargedView: View {
    @StateObject private var photoManager = PhotoManager()
    var photo: Photo

    var body: some View {
        VStack {
            if let image = UIImage(data: photo.imageData) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            Text(photo.title)
                .font(.largeTitle)
                .padding()

            Text(photo.description)
                .font(.body)
                .padding()

            Text("Taken on \(photo.dateTime)")
                .font(.caption)
                .padding()

            Spacer()
        }
        .padding()
        .onAppear {
            // Load photos when the view appears
            photoManager.loadPhotos()
        }
    }
}

