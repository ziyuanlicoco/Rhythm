//
//  SavedDisplayViewController.swift
//  Rhytm
//
//  Created by Ziyuan Li on 5/3/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

class SavedDisplayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    var mySchedule: [Activity] = []
    
    @IBOutlet weak var displaySavedActivities: UICollectionView!
    var menuController = UIMenuController.shared
    var currentSelected = -1
    
    //refresh by fetch data from home view controller every time going to this tab
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let homeVC = self.tabBarController!.viewControllers![0] as! ViewController
        mySchedule = homeVC.savedList
        displaySavedActivities.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bar = self.tabBarController!
        let homeVC = bar.viewControllers![0] as! ViewController
        mySchedule = homeVC.savedList
        
        displaySavedActivities.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        self.displaySavedActivities.delegate = self
        self.displaySavedActivities.dataSource = self
        displaySavedActivities.register(UINib(nibName: "ActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCollectionViewCellIdentifier")
        
        //set up spacing and location of each cell
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 30, left: 6, bottom: 10, right: 6)
        flow.itemSize = CGSize(width: CGFloat(128), height: CGFloat(128))
        flow.minimumInteritemSpacing = 5
        flow.minimumLineSpacing = 10
        
        displaySavedActivities.setCollectionViewLayout(flow, animated: false)
        
        //allow long press a cell to delete
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(deleteActivity))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.displaySavedActivities.addGestureRecognizer(longPressGesture)
        
    }
    

    //handle long press cell and delete from list
    @objc func deleteActivity(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began && mySchedule.count > 0 {
            self.becomeFirstResponder()
            let position = gestureRecognizer.location(in: self.displaySavedActivities)
            let indexPath = self.displaySavedActivities.indexPathForItem(at: position)
            
            //no action if press on place with no cells
            if(indexPath?.item != nil){
                currentSelected = indexPath!.item
                
                //alert to make sure user wants to delete
                let alert = UIAlertController(title: "Do you want to delete this template", message: "you cannot recover it once deleted", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: nil)
                let deleteAction = UIAlertAction(title: "delete", style: .default, handler: deleteSavedActivity)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                self.present(alert, animated: true)
            }
            
        }
    }
    //delete an activity from saved list
    func deleteSavedActivity(action: UIAlertAction){
        let toDelete = mySchedule[currentSelected]
        mySchedule.remove(at: currentSelected)
        displaySavedActivities.reloadData()
        let homeVC = self.tabBarController!.viewControllers![0] as! ViewController
        homeVC.savedList = self.mySchedule
        homeVC.removeFromFirebase(activity: toDelete, collection: "SavedActivities")
    }

    //set up collection view
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mySchedule.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let displaySaved = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCollectionViewCellIdentifier", for: indexPath) as! ActivityCollectionViewCell
        var currentDiscription = mySchedule[indexPath[1]].descrip
        if currentDiscription == ""{
            currentDiscription = "No Description"
        }
        displaySaved.updateText(name: mySchedule[indexPath[1]].name, description: currentDiscription)
        displaySaved.backgroundColor = UIColor.white
        return displaySaved
    }
    
    
    
    
}
