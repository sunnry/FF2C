//
//  SettingTableViewCell.swift
//  FF2C
//
//  Created by sunny sun on 15/12/9.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit


class SettingTableViewCell:UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
