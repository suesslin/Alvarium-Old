//
//  PlayerTableViewCell.swift
//  BeeStats
//
//  Created by Lukas Mueller on 8/6/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playernameLabel: UILabel!
    @IBOutlet weak var playerHeadImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
  
    override func awakeFromNib() {
      
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
