//
//  ActivityCollectionViewCell.swift
//  Rhytm
//
//  Created by Ziyuan Li on 5/3/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

// Set up the collection view cell for displaying saved list
import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateText(name: String, description: String) {
        nameLabel.text = name
        descriptionLabel.text = description
    }

}
