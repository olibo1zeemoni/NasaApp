//
//  CachedAsyncImage.swift
//  NasaApp
//
//  Created by Olibo moni on 26/10/2025.
//

import SwiftUI

/// A view that asynchronously loads and displays an image, with in-memory caching.
///
/// This view first checks a shared `ImageCache` for a cached image. If found, it
/// displays the image immediately. Otherwise, it uses the standard `AsyncImage`
/// to download the image and then stores it in the cache upon successful download.
struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    @ViewBuilder private let content: (Image) -> Content
    @ViewBuilder private let placeholder: () -> Placeholder

    @State private var cachedImage: UIImage?

    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if let cachedImage {
                // If the image is already cached, display it directly.
                content(Image(uiImage: cachedImage))
            } else {
                // Otherwise, use AsyncImage to fetch it.
                AsyncImage(
                    url: url,
                    scale: scale,
                    transaction: transaction
                ) { phase in
                    switch phase {
                    case .success(let image):
                        // When the download succeeds, display the image and cache it.
                        content(image)
                            .onAppear {
                                cacheImage(from: image)
                            }
                    default:
                        // For all other phases (empty, failure), show the placeholder.
                        placeholder()
                    }
                }
            }
        }
        .onAppear(perform: loadImageFromCache)
    }
    
    private func loadImageFromCache() {
        guard let url else { return }
        cachedImage = ImageCache.shared[url]
    }

    private func cacheImage(from image: Image) {
        guard let url else { return }
        
        // To get the UIImage from a SwiftUI Image, we need to render it.
        // This is a common pattern for this task.
        let renderer = ImageRenderer(content: image)
        renderer.scale = scale
        
        if let uiImage = renderer.uiImage {
            ImageCache.shared[url] = uiImage
        }
    }
}
