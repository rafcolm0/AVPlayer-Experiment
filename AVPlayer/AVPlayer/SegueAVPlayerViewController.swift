//
//  AVPlayerViewController.swift
//  AVPlayer
//
//  Created by Rafael Colon on 11/25/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import AVKit
import AVFoundation


class SegueAVPlayerViewController: AVPlayerViewController {
    override func viewDidLoad() {
        self.player = AVPlayer(url: URL(string: AppDelegate.videoURLString)!);
        self.player?.play()
    }
}
