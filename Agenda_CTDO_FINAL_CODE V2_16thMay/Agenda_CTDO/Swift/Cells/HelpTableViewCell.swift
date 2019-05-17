//
//  HelpTableViewCell.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class HelpTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumLabel: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
