//
//  ViewController.swift
//  TableDatabase
//
//  Created by sunshine on 5/3/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//
import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import AVKit

protocol PlaylistDelegate : NSObjectProtocol{
    func addSong(song: Videos)
}


class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   

    @IBOutlet weak var TableView: UITableView!
    //var mydelegate: PlaylistDelegate?
    weak var mydelegate: PlaylistDelegate?
    var table = [Videos]()
    var ref: DatabaseReference!
    //var ref2 : Firebase(url: FIREBASE_URL)
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.delegate = self
        self.TableView.dataSource = self
        
        
        
         TableView.tableFooterView = UIView()
        ref = Database.database().reference().child("songs")
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                //print(snapshot)//worked
                self.table.removeAll()
                
                for video in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let Object = video.value as? [String: AnyObject]
                    let Title = Object?["Title"]
                    let videolink = Object?["Link"]
                     let Image = Object?["Image"]
                    
                    
                    let video = Videos(Title: Title as! String, Link: (videolink as! String),Image: Image as! String)
                    self.table.append(video)
                    //print(video.Title!)//worked
                    
                    self.TableView.reloadData()
                
                    
                }
            }
            
        })
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "playlistCell") as! TableViewCell
        
        let video: Videos
        
        video = table[indexPath.row]
        cell.titleLabel.text = video.Title
        let url = URL(string: video.Image!)
        //print(url)
        let data = try? Data(contentsOf: url!)
        cell.songimageView.image = UIImage(data: data!)
        cell.songimageView.layer.cornerRadius = 10.0
        
        cell.playbutton.tag = indexPath.row
        
        cell.playbutton.addTarget(self, action: #selector(self.buttonClicked(_:)), for: UIControl.Event.touchUpInside)



        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let video: Videos
        video = table[indexPath.row]
        print("tableview")
        print(video.Title!)
        
        self.mydelegate?.addSong(song:video)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonClicked(_ sender:UIButton) {

        let buttonRow = sender.tag
        guard let videoURL = URL(string: table[buttonRow].Link!) else {
            return
        }
        
        let player = AVPlayer(url: videoURL)
        
        let controller = AVPlayerViewController()
        controller.player = player
        
        present(controller, animated: true) {
            player.play()
        }
        
    }
    
    @IBAction func test(_ sender: Any) {
        let video: Videos
        video = table[0]
        print("test")
        print(video.Title!)
        
        self.mydelegate?.addSong(song: video)

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectBtn(_ sender: Any) {
        let video: Videos
        video = table[0]
        print("select")
        print(video.Title!)
        
        self.mydelegate?.addSong(song: video)

        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

