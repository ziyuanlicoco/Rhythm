//
//  SearchableSavedDataTableViewCell.swift
//  Rhytm
//
//  Created by Ziyuan Li on 5/4/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//
//Set up table cell under search bar

import UIKit

class SearchableSavedDataTableViewCell: UITableViewCell {

    @IBOutlet weak var displayName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateText(text: String) {
        displayName.text = text
    }
    
}
