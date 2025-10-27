//
//  VideoPlayerView.swift
//  NasaApp
//
//  Created by Olibo moni on 26/10/2025.
//

import SwiftUI
import AVKit


struct VideoPlayerView: UIViewRepresentable {
    let url: URL
    var isPlaying: Bool

    func makeUIView(context: Context) -> LoopingPlayerView {
        return LoopingPlayerView(url: url, isPlaying: isPlaying)
    }

    func updateUIView(_ uiView: LoopingPlayerView, context: Context) {
        uiView.set(isPlaying: isPlaying)
    }
    
    /// A custom UIView that manages an AVPlayerLayer for looping video playback.
    class LoopingPlayerView: UIView {
        private var player: AVQueuePlayer?
        private var playerLayer: AVPlayerLayer?
        private var playerItem: AVPlayerItem?
        private var playerLooper: AVPlayerLooper?

        init(url: URL, isPlaying: Bool) {
            super.init(frame: .zero)
            
            let item = AVPlayerItem(url: url)
            self.playerItem = item
            
            let player = AVQueuePlayer(playerItem: item)
            self.player = player
            
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resizeAspectFill
            self.playerLayer = playerLayer
            
            // Add the layer to the view's layer hierarchy.
            layer.addSublayer(playerLayer)

            // Create a player looper to handle continuous playback.
            // A strong reference to the looper must be maintained for looping to work.
            self.playerLooper = AVPlayerLooper(player: player, templateItem: item)
            
            // Mute the video.
            player.isMuted = true
            if isPlaying {
                player.play()
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            // Ensure the player layer always fills the view's bounds.
            playerLayer?.frame = bounds
        }
        
        /// Updates the playback state of the video player.
        func set(isPlaying: Bool) {
            if isPlaying {
                player?.play()
            } else {
                player?.pause()
            }
        }
    }
}
