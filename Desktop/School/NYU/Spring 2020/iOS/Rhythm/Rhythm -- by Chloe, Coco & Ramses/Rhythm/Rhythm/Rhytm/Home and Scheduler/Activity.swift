//
//  Activity.swift
//  Rhytm
//
//  Created by Ziyuan Li on 4/24/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

//Codable ensures that it can be passed into fireStore database as custom object
class Activity: NSObject, Codable{
    var name: String
    var descrip: String
    var start_time = Date()
    var end_time = Date()
    //var list: [String] = []
    var color: String = ""
    var song = Videos(Title:" temp", Link: "temp",Image:"none" )
    
    init(myName: String, myDesc: String, myStart: Date, myEnd: Date, myColor: String, mySong:Videos) {
        self.name = myName
        self.descrip = myDesc
        self.start_time = myStart
        self.end_time = myEnd
        self.color = myColor
        self.song = mySong
        super.init()
        
    }
}
