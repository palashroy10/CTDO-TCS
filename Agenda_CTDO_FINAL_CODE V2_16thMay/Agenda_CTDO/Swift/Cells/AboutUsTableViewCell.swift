//
//  AboutUsTableViewCell.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/9/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImgVw: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
