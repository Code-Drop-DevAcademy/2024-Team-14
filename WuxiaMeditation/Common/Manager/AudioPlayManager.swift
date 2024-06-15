//
//  AudioPlayManager.swift
//  운기조식
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import AVFoundation

final class AudioPlayManager {
    static let shared = AudioPlayManager()
    private init() {}
    
    var audioPlayer: AVAudioPlayer?
    
    func playSound(sound: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                
            }
        }
            
    }
}
