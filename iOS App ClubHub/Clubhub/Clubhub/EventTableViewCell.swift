//
//  EventTableViewCell.swift
//  Clubhub
//
//  Created by Alex Pegram on 4/18/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var eventName: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var createdBy: UILabel!
    
    @IBOutlet weak var eventDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
