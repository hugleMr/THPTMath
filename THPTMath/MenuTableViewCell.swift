//
//  MenuTableViewCell.swift
//  THPTMath
//
//  Created by HungLe on 10/25/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var name_icon: UILabel!
    @IBOutlet weak var image_icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
