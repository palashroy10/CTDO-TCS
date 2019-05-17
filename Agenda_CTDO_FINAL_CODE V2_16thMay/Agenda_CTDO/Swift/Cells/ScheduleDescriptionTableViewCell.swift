//
//  ScheduleDescriptionTableViewCell.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ScheduleDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var meetingNameLabel: UILabel!
    @IBOutlet weak var meetingDescriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
