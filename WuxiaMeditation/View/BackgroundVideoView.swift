//
//  BackgroundVideoView.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewRepresentable {
    @Binding var energyState: EnergyState
    
    func updateUIView(_ uiView: LoopingPlayerUIView, context: UIViewRepresentableContext<PlayerView>) {
        uiView.updateVideoSource(energyState)
    }

    func makeUIView(context: Context) -> LoopingPlayerUIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}

class LoopingPlayerUIView: UIView {
    let playerLayer = AVPlayerLayer()
    var playerLooper: AVPlayerLooper?
    var energyState: EnergyState = .level0
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateVideoSource(energyState)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    func updateVideoSource(_ energyState: EnergyState){
        playerLooper = nil
        let fileUrl = Bundle.main.url(forResource: "background\(energyState.rawValue)", withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        // Create a new player looper with the queue player and template item
        
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        // Start the movie
        player.play()
    }
}
