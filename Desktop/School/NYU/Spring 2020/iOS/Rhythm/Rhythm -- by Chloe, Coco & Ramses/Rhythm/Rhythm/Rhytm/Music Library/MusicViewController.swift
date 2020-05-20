//
//  MusicViewController.swift
//  Rhytm
//
//  Created by sunshine on 5/3/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation



class MusicViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/rhythm-4586f.appspot.com/o/songs%2FNils%20Frahm%20-%20You.mp3?alt=media&token=94d6ed5f-7ca6-463f-a94c-5e5dcebbf2c0")
    
    var player2: AVPlayer!
    var player3: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressButton(){
        
        let player = AVPlayer(url: videoURL!)
        
        if player.timeControlStatus == .playing {
               player.pause()
               button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
           } else if player.timeControlStatus == .paused {
               player.play()
               button.setBackgroundImage(UIImage(systemName: "stop.circle"), for: .normal)
                
           }
        
    }
    /*
    @IBAction func play(_ sender: UIButton) {
        if let player2 = player2,player2.isPlaying{
                  button2.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
                   player2.stop()
                   
               }else{
                   button2.setBackgroundImage(UIImage(systemName:"stop.circle" ), for: .normal)
                   let urlString = Bundle.main.path(forResource:"Comfort Zone" , ofType: "mp3")
                   do{
                        if let player = player,player.isPlaying {
                            player.stop()
                            button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
                        }
                    if let player3 = player3,player3.isPlaying {
                        player3.stop()
                        button3.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
                    }
                       try AVAudioSession.sharedInstance().setMode(.default)
                       try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                       guard let urlString = urlString else{
                           return
                       }
                       player2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                       guard let player2  = player2 else{
                           return
                       }
                       player2.play()
                       
                   }catch{
                       print("something went wrong.")
                   }
               }
    }
    @IBAction func play3(_ sender: UIButton) {
        if let player3 = player3,player3.isPlaying{
                  button3.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
                   player3.stop()
                   
               }else{
                   button3.setBackgroundImage(UIImage(systemName:"stop.circle" ), for: .normal)
                   let urlString = Bundle.main.path(forResource:"You" , ofType: "mp3")
                   do{
                    
                    if let player2 = player2,player2.isPlaying {
                        player2.stop()
                        button2.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
                    }
                    if let player = player,player.isPlaying {
                        player.stop()
                        button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
                    }
                       try AVAudioSession.sharedInstance().setMode(.default)
                       try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                       guard let urlString = urlString else{
                           return
                       }
                       player3 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                       guard let player3  = player3 else{
                           return
                       }
                       player3.play()
                       
                   }catch{
                       print("something went wrong.")
                   }
               }
 
 }
 */
}
