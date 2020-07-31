//
//  Flag.swift
//  pr1-3
//
//  Created by user165519 on 4/17/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class Flag: UITableViewCell {
    //MARK
    
    @IBOutlet weak var cntrFlag: UIImageView!
    @IBOutlet weak var cntrName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
