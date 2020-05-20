//
//  addViewController.swift
//  Rhytm
//
//  Created by Ziyuan Li on 5/8/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class addViewController: UIViewController {
    
    
    @IBOutlet weak var addNew: UIButton!
    @IBOutlet weak var addSave: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    //segue
    @IBAction func createNew(_ sender: Any) {
        self.performSegue(withIdentifier: "createNewSegue", sender: self)
    }
    @IBAction func createSave(_ sender: Any) {
        self.performSegue(withIdentifier: "fromSaveSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewSegue" {
            let bar = self.tabBarController!
            let homeVC = bar.viewControllers![0] as! ViewController
            let vc: NewActivityViewController = segue.destination as! NewActivityViewController
            vc.delegate = homeVC
            print(homeVC)

        }
        else if segue.identifier == "fromSaveSegue"{
            let bar = self.tabBarController!
            let homeVC = bar.viewControllers![0] as! ViewController
            let vc: SaveActivityViewController = segue.destination as! SaveActivityViewController
            vc.savedSchedule = homeVC.savedList
            vc.delegate = homeVC

        }
    }
}
