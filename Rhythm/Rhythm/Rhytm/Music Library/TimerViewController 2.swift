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
    
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var timeCount: UILabel!
    
    var audioplayer = AVAudioPlayer()
    var startTime : Date!
    var endTime : Date!
    var schedule: Activity!
    var difference:Int!
    var timer = Timer()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        activityName.text = schedule.name
        //timeCount.text = schedule.color
        startTime = schedule.start_time
        endTime = schedule.end_time
        calculateDifference()
        do{
            let audioPath = Bundle.main.path(forResource: "You", ofType: ".mp3")
            try audioplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }catch{
            //ERROR
        }
        
        
        
    }
    
    func calculateDifference(){
        let formatter = DateComponentsFormatter()
           formatter.allowedUnits = [.second]
           formatter.unitsStyle = .full
           difference = Int(endTime.timeIntervalSince(startTime))
         
           //let difference = formatter.string(from: startTime, to: endTime)!
           //print(difference)//output "8 seconds"
           timeCount.text = String(difference)
    }
    @IBAction func startCount(_ sender: Any) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.Action),userInfo:nil,repeats:true )
    
    }
    
    @IBAction func pauseCount(_ sender: Any) {
        timer.invalidate()
        audioplayer.stop()
    }
    @objc func Action(){
        difference -= 1
        timeCount.text = String(difference)
        if(!audioplayer.isPlaying){
            audioplayer.play()
        }
        if(difference == 0){
            timer.invalidate()
            timeCount.text = "Time Up!"
            audioplayer.stop()
        }
        
    }
    
    
}
