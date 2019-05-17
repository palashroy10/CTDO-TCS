//
//  TableViewCell.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/8/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImgVw: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
