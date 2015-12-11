//
//  PortFolioHoldCell.swift
//  FF2C
//
//  Created by sunny sun on 15/12/11.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit

class PortFolioHoldCell: UITableViewCell {

    @IBOutlet weak var symbol: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var percentage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
