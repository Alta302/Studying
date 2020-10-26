//
//  CustomViewCell.swift
//  AutoLayout
//
//  Created by 정창용 on 2020/09/23.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var faceImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
