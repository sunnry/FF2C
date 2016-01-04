//
//  QuoteDetailPriceChangeCell.swift
//  FF2C
//
//  Created by sunny sun on 15/12/28.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit

struct QuoteDetailPriceCellConfig{
    static let underlineHeight:CGFloat = 0.3
    static let xPos:CGFloat = 15.0
    static let yPos:CGFloat = 19.0
    static let underlineColor:UIColor = UIColor.lightGrayColor()
}

class QuoteDetailPriceChangeCell: UITableViewCell {
    
    @IBOutlet weak var currentPrice: UILabel!
    
    @IBOutlet weak var priceChange: UILabel!
    
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
        
        underline = UIView(frame: CGRect(x: QuoteDetailPriceCellConfig.xPos, y: QuoteDetailPriceCellConfig.yPos, width: (width - QuoteDetailPriceCellConfig.xPos*2), height: QuoteDetailPriceCellConfig.underlineHeight))
        
        underline.backgroundColor = QuoteDetailPriceCellConfig.underlineColor
        
        self.contentView.addSubview(underline)
    }
    
}