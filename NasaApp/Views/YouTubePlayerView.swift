//
//  YouTubeVideoView.swift
//  NasaApp
//
//  Created by Olibo moni on 26/10/2025.
//

import SwiftUI
import WebKit

struct YouTubeVideoView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {

        let embedURL = "https://www.youtube-nocookie.com/embed/\(videoID)?autoplay=1&loop=1&playlist=\(videoID)&playsinline=1"
        var request = URLRequest(url: URL(string: embedURL)!)
        
        request.addValue("https://com.zeemoni.NasaApp", forHTTPHeaderField: "Referer")  // Replace with your app's domain or a placeholder
        request.addValue("strict-origin-when-cross-origin", forHTTPHeaderField: "Referrer-Policy")
        
        let config = WKWebViewConfiguration()
        config.limitsNavigationsToAppBoundDomains = true  // Enable app-bound restrictions
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: config)
        
        webView.load(request)
        
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No updates needed for this simple embed
    }
}

struct PreviewView: View {
    var body: some View {
        YouTubeVideoView(videoID: "wDchsz8nmbo")
            .frame(height: 240)
    }
}

#Preview {
    PreviewView()
}
