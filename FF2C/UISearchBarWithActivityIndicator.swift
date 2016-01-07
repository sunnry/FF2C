//
//  UISearchBarWithActivityIndicator.swift
//  FF2C
//
//  Created by sunny sun on 16/1/7.
//  Copyright © 2016年 sunny sun. All rights reserved.
//

import UIKit

class UISearchBarWithActivityIndicator: UISearchBar {
    
    
    override func layoutSubviews() {
        
        if let topView:UIView = subviews[0] as UIView{
            for view in topView.subviews{
                if view.isKindOfClass(UIButton.self){
                    if let cancel = view as? UIButton{
                        print(cancel.titleLabel?.text)
                        cancel.setTitleColor(UIColor.blackColor(), forState: .Normal)
                        cancel.setTitle("取消", forState: .Normal)
                        break
                    }
                }
            }
            
        }
    
        
        super.layoutSubviews()
    }
    
}
