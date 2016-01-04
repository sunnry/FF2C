//
//  QuoteDetailCommonCell.swift
//  FF2C
//
//  Created by sunny sun on 16/1/4.
//  Copyright © 2016年 sunny sun. All rights reserved.
//

import UIKit

struct QuoteDetailCommonCellConfig{
    static let underlineHeight:CGFloat = 0.3
    static let xPos:CGFloat = 15.0
    static let yPos:CGFloat = 19.0
    static let underlineColor:UIColor = UIColor.lightGrayColor()
}


class QuoteDetailCommonCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    
    var underline:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func reformUnderline(width:CGFloat){
        
        underline = UIView(frame: CGRect(x: QuoteDetailCommonCellConfig.xPos, y: QuoteDetailCommonCellConfig.yPos, width: (width - QuoteDetailCommonCellConfig.xPos*2), height: QuoteDetailCommonCellConfig.underlineHeight))
        
        underline.backgroundColor = QuoteDetailCommonCellConfig.underlineColor
        
        self.contentView.addSubview(underline)
    }

}