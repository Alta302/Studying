//
//  CustomTableViewCell.swift
//  CustomCell
//
//  Created by 정창용 on 2020/09/16.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var letfLabel: UILabel!
    @IBOutlet var rightLabel: UILabel!
    @IBOutlet var middleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
