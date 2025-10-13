//
//  PhotoRowView.swift
//  NasaApp
//
//  Created by Olibo moni on 12/10/2025.
//

import SwiftUI

struct PhotoRowView: View {
    @Binding var photoInfo: PhotoInfo

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            AsyncImage(url: photoInfo.url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "photo.trianglebadge.exclamationmark")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 80, height: 80)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(photoInfo.title)
                    .font(.headline)

                Text(photoInfo.date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(photoInfo.description)
                    .font(.body)
                    .lineLimit(1)
                    .padding(.top, 4)
            }
            FavoriteButton(isSet: $photoInfo.isFavorite)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let samplePhoto = PhotoInfo(
        title: "Title",
        url: URL(
            string:
                "https://apod.nasa.gov/apod/image/2401/ngc1333_hubble_960.jpg"
        )!,
        description:
            "This is a sample description of the astronomy picture of the day. It provides some context about the celestial object being displayed.",
        date: "2025-10-12"
    )
    return PhotoRowView(photoInfo: .constant(samplePhoto))
        .padding()
}
