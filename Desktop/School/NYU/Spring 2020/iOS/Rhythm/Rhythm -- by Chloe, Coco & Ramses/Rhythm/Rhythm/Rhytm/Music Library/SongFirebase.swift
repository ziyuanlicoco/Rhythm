//
//  SongFirebase.swift
//  Rhytm
//
//  Created by sunshine on 5/4/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import AVFoundation
import FirebaseStorage
import UIKit

class SongFirebase:UIViewController{
   
    @IBOutlet weak var playbtn: UIButton!
    var songs: StorageReference{
        return Storage.storage().reference().child("images")
    }
    @IBOutlet weak var songLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func playSong(_ sender: Any) {
        let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/rhythm-4586f.appspot.com/o/songs%2FNils%20Frahm%20-%20You.mp3?alt=media&token=94d6ed5f-7ca6-463f-a94c-5e5dcebbf2c0")
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
}
