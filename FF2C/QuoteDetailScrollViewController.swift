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
    var nvBackButton:UIBarButtonItem?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?,symbol:String?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.symbol = nil
        
        nvBackButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action:"nvBackButtonAction:")
        
        if let s = symbol{
            self.symbol = s
        }
    }

    func nvBackButtonAction(sender: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nvBackButton
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
