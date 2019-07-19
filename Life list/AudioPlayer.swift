//
//  AudioPlayer.swift
//  Life list
//
//  Created by girlswhocode on 7/18/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import Foundation
import AVFoundation

enum music: String {
    case BlindingLights
    case perfectRingTone
}

/// Responsible for handling Audio logic.
class AudioPlayer {
    static let shared = AudioPlayer()
    private var player: AVAudioPlayer?
    
    func playMusic(_ music: music) {
        //get the url that responds to the track number
        guard let url = Bundle.main.url(forResource: music.rawValue, withExtension: "mp3") else { return }
        
        do {
            //set up the player with the correct track
            player = try AVAudioPlayer(contentsOf: url)
            
            //start the music!
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopPlayingMusic() {
        player?.stop()
        player = nil //reset the player
    }
}
