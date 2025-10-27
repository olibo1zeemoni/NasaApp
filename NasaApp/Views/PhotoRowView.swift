//
//  PhotoRowView.swift
//  NasaApp
//
//  Created by Olibo moni on 12/10/2025.
//

import SwiftUI

struct PhotoRowView: View {
    @Binding var photoInfo: PhotoInfo
    let url = Bundle.main.url(forResource: "kids-swimming", withExtension: "mp4")!

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
                YouTubeVideoView(videoID: photoInfo.url.lastPathComponent)
                    .onAppear {
                        print(photoInfo.url.lastPathComponent)
                    }
            case .other:
                VideoPlayerView(url: photoInfo.url, isPlaying: true)
            }
        }
}








#Preview {
    let samplePhoto = PhotoInfo(
        title: "Blue Ghost Shadow",
        copyright: "NASA/JPL-Caltech",
        url: URL(string: "https://apod.nasa.gov/apod/image/2503/BlueGhostShadow_Firefly_960.jpg")!,
        description: "This is a sample description of the astronomy picture of the day.",
        date: "2024-12-25",
        mediaType: .image
    )
    let bundleURL = Bundle.main.url(forResource: "kids-swimming", withExtension: "mp4")!
    let liveURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
    let youTubeUrl = URL(string: "https://www.youtube.com/embed/my1euFQHH-o?rel=0")!
    let sampleVideo = PhotoInfo(
        title: "Big Buck Bunny",
        copyright: "Google APIs",
        url: youTubeUrl,
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

