//
//  TableViewCell.swift
//  TableDatabase
//
//  Created by sunshine on 5/3/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var songimageView : UIImageView!
    @IBOutlet weak var playbutton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
