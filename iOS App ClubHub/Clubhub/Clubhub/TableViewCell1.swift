//
//  TableViewCell1.swift
//  Clubhub
//
//  Created by Lucas Solem on 3/22/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import GoogleMaps

class TableViewCell1: UITableViewCell {
    
    @IBOutlet weak var GMap: GMSMapView!
    @IBOutlet weak var lblClub: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
