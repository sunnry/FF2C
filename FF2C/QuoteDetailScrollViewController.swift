//
//  QuoteDetailScrollViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/25.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit


class QuoteDetailScrollViewController:UIViewController {
    
    var symbol:String?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?,symbol:String?){
        self.symbol = nil
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if let s = symbol{
            self.symbol = s
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
