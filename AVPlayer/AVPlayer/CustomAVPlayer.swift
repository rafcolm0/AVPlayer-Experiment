//
//  CustomAVPlayer.swift
//  AVPlayer
//
//  Created by Rafael Colon on 11/25/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

class CustomAVPlayer: AVPlayer {
    override init() {
        super.init();
        setUpObservers();
    }
    
    override init(url URL: URL) {
        super.init(url: URL);
        setUpObservers();
    }

    override init(playerItem item: AVPlayerItem?) {
        super.init(playerItem: item);
        setUpObservers();
    }
    
    func setUpObservers(){
        self.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        self.currentItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
        self.currentItem?.addObserver(self, forKeyPath: "playbackBufferFull", options: .new, context: nil)
    }
    
    func destroyObservers(){
        self.currentItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty");
        self.currentItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp");
        self.currentItem?.removeObserver(self, forKeyPath: "playbackBufferFull");
    }
    
    deinit {
        destroyObservers();
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is AVPlayerItem {
            switch keyPath {
            case "playbackBufferEmpty":   //bufferring: show loading view
                break
            case "playbackLikelyToKeepUp":  //still bufferring but ready to play
                break
            case "playbackBufferFull":  //stopped bufferring
                break
            default:
                break;
            }
        }
    }
}
