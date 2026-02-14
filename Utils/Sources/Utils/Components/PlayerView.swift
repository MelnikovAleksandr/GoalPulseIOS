//
//  PlayerView.swift
//  Utils
//
//  Created by Александр Мельников on 21.12.2025.
//
import UIKit
import AVFoundation
import SwiftUI

class PlayerView: UIView {
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    init(videoName: String, videoType: String) {
        super.init(frame: .zero)
        guard let url = Bundle.module.url(forResource: videoName, withExtension: videoType) else {
            return
        }
        
        self.player = AVPlayer(url: url)
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        self.player.play()
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.player.seek(to: .zero)
                self.player.play()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

public struct LoadingPlayerView: UIViewRepresentable {
    private var videoURLString: String
    private var videoTypeString: String = "mp4"
    
    public init(videoName: String) {
        self.videoURLString = videoName
    }
    
    public func makeCoordinator() -> UIView {
        return PlayerView(videoName: videoURLString, videoType: videoTypeString)
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
    
    public func makeUIView(context: Context) -> UIView {
        return context.coordinator
    }
    
    public static func dismantleUIView(_ uiView: UIView, coordinator: UIView) {
        (uiView as? PlayerView)?.player.pause()
    }
}
