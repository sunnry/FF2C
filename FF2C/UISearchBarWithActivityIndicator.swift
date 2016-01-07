//
//  UISearchBarWithActivityIndicator.swift
//  FF2C
//
//  Created by sunny sun on 16/1/7.
//  Copyright © 2016年 sunny sun. All rights reserved.
//

import UIKit

class UISearchBarWithActivityIndicator: UISearchBar {
    
    var activityIndicator:UIActivityIndicatorView?
    
    override func layoutSubviews() {
        
        if let topView:UIView = subviews[0] as UIView{
            //set cancel button text to chinese font
            for view in topView.subviews{
                if view.isKindOfClass(UIButton.self){
                    if let cancel = view as? UIButton{
                        //print(cancel.titleLabel?.text)
                        cancel.setTitleColor(UIColor.blackColor(), forState: .Normal)
                        cancel.setTitle("取消", forState: .Normal)
                        break
                    }
                }
            }
            //add activityIndicator ot UITextField
            for tfview in topView.subviews{
                if tfview.isKindOfClass(UITextField.self){
                    if let searchField = tfview as? UITextField{
                        if activityIndicator == nil{
                            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
                            
                            if let lv = searchField.leftView{
                                activityIndicator?.center = CGPointMake((lv.bounds.origin.x + lv.bounds.size.width/2), (lv.bounds.origin.y + lv.bounds.size.height/2))
                            }
                            activityIndicator?.hidesWhenStopped = true
                            activityIndicator?.backgroundColor = UIColor.whiteColor()
                            searchField.leftView?.addSubview(activityIndicator!)
                        }
                    }
                }
            }
        }
    
        super.layoutSubviews()
    }
    
    
    func startActivity(){
        if let avi = self.activityIndicator{
            avi.startAnimating()
        }
    }
    
    func finishActivity(){
        if let avi = self.activityIndicator{
            avi.stopAnimating()
        }
    }
    
    
}
