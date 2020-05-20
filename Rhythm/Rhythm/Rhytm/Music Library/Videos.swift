//
//  Videos.swift
//  TableDatabase
//
//  Created by sunshine on 5/3/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import Foundation

class Videos:Codable {
    
    var Title: String?
    var Link: String?
    var Image: String?
    
    init(Title: String?, Link: String?,Image :String?) {
        self.Title = Title;
        self.Link = Link;
        self.Image = Image;
        
    }
    
    
    
    
    
}
