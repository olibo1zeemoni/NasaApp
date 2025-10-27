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
            mediaView
            .frame(width: 60, height: 60)
            .background(Color.red.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(photoInfo.title)
                    .font(.headline)
                    .lineLimit(2, reservesSpace: true)
                Text(photoInfo.date)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            Spacer()
            FavoriteButton(isSet: $photoInfo.isFavorite)
        }
        .frame(height: 60)
    }
}

extension PhotoRowView {
    @ViewBuilder
        private var mediaView: some View {
            switch photoInfo.mediaType {
            case .image:
                CachedAsyncImage(url: photoInfo.url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        Color.clear
                        ProgressView()
                    }
                }
            case .video:
                VideoPlayerView(url: photoInfo.url, isPlaying: true)
//                    .overlay(
//                        Image(systemName: "play.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.white.opacity(0.7))
//                            .allowsHitTesting(false) // Prevents the icon from blocking gestures.
//                    )
            case .other:
                EmptyView()
            }
        }
}








#Preview {
    let samplePhoto = PhotoInfo(
        title: "Jupiter's Swirling Storms",
        copyright: "NASA/JPL-Caltech",
        url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1333_hubble_960.jpg")!,
        description: "This is a sample description of the astronomy picture of the day.",
        date: "2024-12-25",
        mediaType: .image
    )
    
    let sampleVideo = PhotoInfo(
        title: "Perseverance Rover Landing",
        copyright: "NASA/JPL-Caltech",
        url: URL(string: "https://www.nasa.gov/wp-content/uploads/2022/07/marstrekker-perseverance-8k-v2-final.mp4")!,
        description: "Onboard cameras capture the dramatic entry, descent, and landing.",
        date: "2024-12-24",
        mediaType: .video
    )
    
    VStack {
        PhotoRowView(photoInfo: .constant(samplePhoto))
        Divider()
        PhotoRowView(photoInfo: .constant(sampleVideo))
    }
    .padding()
}
