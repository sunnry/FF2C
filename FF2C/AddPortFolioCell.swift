//
//  AddPortFolioCell.swift
//  FF2C
//
//  Created by sunny sun on 15/12/11.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit


class AddPortFolioCell: UITableViewCell {
    
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var DelButton: UIButton!
    
    weak var delegate:quoteDelegate?
    
    @IBAction func AddButtonAction(sender: AnyObject) {
        
        delegate?.didShowQuoteController()
    }
    
    @IBAction func delButtonAction(sender: AnyObject) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}