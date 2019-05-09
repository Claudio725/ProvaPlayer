//
//  ViewController.swift
//  ProvaPlayer
//  Autor: Claudio José da Silva Menezes
//  Telefone: 99464-7174
//  Created by MacBook Pro i7 on 09/05/19.
//  Copyright © 2019 CJSM. All rights reserved.
//

import UIKit

import BitmovinPlayer

final class ViewController: UIViewController {
    
    var player: BitmovinPlayer?
    
    deinit {
        player?.destroy()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        // Define needed resources
        guard let streamUrl = URL(string: "https://ctsr525679amd-theplatform.akamaized.net/video/Telecine_-_Production/344/733/TVODR-017410_58790469901_mp4_video_640x360_408000_primary_audio_eng_1_1556900803857.m3u?hdnts=st=1556914995~exp=1556915325~acl=/Telecine_-_Production/344/733/*~hmac=ce3f1164fdd69e2626a831691130b6c156f3e1a3ab872ebe65a548f60cde4e81"),
            let posterUrl = URL(string: "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/poster.jpg") else {
                return
        }
        
        // Create player configuration
        let config = PlayerConfiguration()
        
        do {
            try config.setSourceItem(url: streamUrl)
            
            // Set a poster image
            config.sourceItem?.posterSource = posterUrl
            
            // Create player based on player configuration
            let player = BitmovinPlayer(configuration: config)
            
            // Create player view and pass the player instance to it
            let playerView = BMPBitmovinPlayerView(player: player, frame: .zero)
            
            // Listen to player events
            player.add(listener: self)
            
            playerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            playerView.frame = view.bounds
            
            view.addSubview(playerView)
            view.bringSubviewToFront(playerView)
            
            self.player = player
        } catch {
            print("Configuration error: \(error)")
        }
    }
}

extension ViewController: PlayerListener {
    
    func onPlay(_ event: PlayEvent) {
        print("onPlay \(event.time)")
    }
    
    func onPaused(_ event: PausedEvent) {
        print("onPaused \(event.time)")
    }
    
    func onTimeChanged(_ event: TimeChangedEvent) {
        print("onTimeChanged \(event.currentTime)")
    }
    
    func onDurationChanged(_ event: DurationChangedEvent) {
        print("onDurationChanged \(event.duration)")
    }
    
    func onError(_ event: ErrorEvent) {
        print("onError \(event.message)")
    }
}


