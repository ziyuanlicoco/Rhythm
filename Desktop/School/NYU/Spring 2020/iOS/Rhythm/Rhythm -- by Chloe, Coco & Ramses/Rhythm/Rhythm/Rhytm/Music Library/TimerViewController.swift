//
//  TimerViewController.swift
//  Rhytm
//
//  Created by sunshine on 5/5/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class TimerViewController : UIViewController{
    
    
    @IBOutlet weak var goBack: UIButton!

    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    
    var player = AVPlayer()
    var startTime : Date!
    var endTime : Date!
    var schedule: Activity!
    var difference:Int!
    var timer = Timer()
    var song = Videos(Title:" temp", Link: "https://firebasestorage.googleapis.com/v0/b/rhythm-4586f.appspot.com/o/songs%2FNils%20Frahm%20-%20You.mp3?alt=media&token=94d6ed5f-7ca6-463f-a94c-5e5dcebbf2c0",Image:"image" )
    var animating : Bool = false
    override func viewDidLoad(){
        super.viewDidLoad()
        print(schedule.song)
        activityName.text = schedule.name
        //timeCount.text = schedule.color
        startTime = schedule.start_time
        endTime = schedule.end_time
        songName.text = schedule.song.Title
        
        let url = URL(string: schedule.song.Image!)
        let data = try? Data(contentsOf: url!)
       
        if data != nil {
            songImage.image = UIImage(data: data!)
        }
        calculateDifference()
        
        let videoURL = URL(string: song.Link!)
        player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        
        songImage.roundImage()
        songImage.layer.cornerRadius = songImage.frame.height/2
        songImage.clipsToBounds = true
        songImage.layer.borderWidth = 5
        songImage.layer.borderColor = UIColor.white.cgColor

    }
    
    @IBAction func goBack(_ sender: Any) {
        //only going back now for testing purporse
        player.pause()
        dismiss(animated: true, completion: nil)
       
    }
    

    func calculateDifference(){
        let formatter = DateComponentsFormatter()
           formatter.allowedUnits = [.second]
           formatter.unitsStyle = .full
           difference = Int(endTime.timeIntervalSince(startTime))
         
           //let difference = formatter.string(from: startTime, to: endTime)!
           //print(difference)//output "8 seconds"
           
            let hour = (difference / 3600)
            let minute = (difference % 3600) / 60
            let second = (difference % 3600) % 60
          
        timeCount.text = String(format: "%02i:%02i:%02i", hour, minute, second)
        
            
        
    }
    @IBAction func startCount(_ sender: Any) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.Action),userInfo:nil,repeats:true )
        
       /*UIView.animate(withDuration: 2.0, animations: {
           self.songImage.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
       })
 */
        if(!animating) {
            animating = true;
            spinWithOptions(options: UIView.AnimationOptions.curveEaseIn);
        }
        
    
    }
    
   
    
    func spinWithOptions(options: UIView.AnimationOptions) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: options, animations: { () -> Void in
            let val : CGFloat = CGFloat((M_PI / Double(2.0)));
            self.songImage.transform = self.songImage.transform.rotated(by: val)
        }) { (finished: Bool) -> Void in

            if(finished) {
                if(self.animating){
                    self.spinWithOptions(options: UIView.AnimationOptions.curveLinear)
                } else if (options != UIView.AnimationOptions.curveEaseOut) {
                    self.spinWithOptions(options: UIView.AnimationOptions.curveEaseOut)
                }
            }

        }
    }
    
    @IBAction func pauseCount(_ sender: Any) {
        timer.invalidate()
        player.pause()
        animating = false
        
    }
    @objc func Action(){
        difference -= 1
         let hour = (difference / 3600)
         let minute = (difference % 3600) / 60
         let second = (difference % 3600) % 60
                 
        timeCount.text = String(format: "%02i:%02i:%02i", hour, minute, second)
        
        
        
        if(player.timeControlStatus != .playing){
            player.play()
        }
        if(difference == 0){
            timer.invalidate()
            timeCount.text = "Time Up!"
            player.pause()
        }
        
    }
    
    
}
