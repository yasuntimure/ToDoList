//
//  ProfileImageButton.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-23.
//

import SwiftUI
import PhotosUI

struct ProfileImagePicker: View {

    @State private var ProfileImage: Image = Image(systemName: "person.circle.fill")
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var isLoading = false

    var size = ScreenSize.width/3.5

    var body: some View {
        ZStack {
            PhotosPicker(selection: $selectedPhoto, matching: .images) {
                ProfileImage
                    .resizable()
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .cornerRadius(size)
                    .overlay(
                        RoundedRectangle(cornerRadius: size)
                            .stroke(Color.primary, lineWidth: 2)
                    )
                    .shadow(radius: 0.5)
            }
            if isLoading {
                ProgressView()
                    .tint(.gray)
            }
        }
        .onChange(of: selectedPhoto) { item in
            Task { await loadImage(from: item) }
        }
    }

    private func loadImage(from item: PhotosPickerItem?) async {
        guard let item = item else { return }
        if let data = try? await item.loadTransferable(type: Data.self),
           let uiImage = UIImage(data: data) {
            ProfileImage = Image(uiImage: uiImage)
        }
    }

}

struct ProfileImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImagePicker()
    }
}
