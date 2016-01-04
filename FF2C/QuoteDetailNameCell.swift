//
//  QuoteDetailNameCell.swift
//  FF2C
//
//  Created by sunny sun on 15/12/28.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit

struct QuoteDetailNameCellConfig{
    static let underlineHeight:CGFloat = 1.0
    static let xPos:CGFloat = 15.0
    static let yPos:CGFloat = 19.0
    static let underlineColor:UIColor = UIColor.blackColor()
}

class QuoteDetailNameCell:UITableViewCell{
    
    @IBOutlet weak var bigSymbol: UILabel!
    
    @IBOutlet weak var smallName: UILabel!
    
    var underline:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder)
    }
    
    func reformUnderline(width:CGFloat){
        
        underline = UIView(frame: CGRect(x: QuoteDetailNameCellConfig.xPos, y: QuoteDetailNameCellConfig.yPos, width: (width - QuoteDetailNameCellConfig.xPos*2), height: QuoteDetailNameCellConfig.underlineHeight))
        
        underline.backgroundColor = QuoteDetailNameCellConfig.underlineColor
        
        self.contentView.addSubview(underline)
    }
    
}