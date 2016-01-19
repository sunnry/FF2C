//
//  MacroScrollViewController.swift
//  FF2C
//
//  Created by sunny sun on 16/1/18.
//  Copyright © 2016年 sunny sun. All rights reserved.
//

import UIKit


enum MacroScrollViewMask:Int{
    case OIL
    case CHINA
    case US
}

class MacroScrollViewController: UIViewController,UIScrollViewDelegate {
    
    var backItem:UIBarButtonItem?
    var masks:MacroScrollViewMask?
    var ctrl:UniversalLineViewController?
    
    var ctrlsArray:[UniversalLineViewController]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let count = ctrlsArray.count
        
        if count > 0{
            var xoffset:CGFloat = 0
            var yoffset:CGFloat = 0
            for ctrl in ctrlsArray{
                let point = CGPoint(x: xoffset, y: yoffset)
                let size = CGSize(width: self.view.frame.width, height: (self.view.frame.height/5)*3)
                
                ctrl.view.frame = CGRect(origin: point, size: size)
                
                yoffset = ctrl.view.frame.height + yoffset
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = backItem

        for ctrl in ctrlsArray{
            self.view.addSubview(ctrl.view)
            self.addChildViewController(ctrl)
        }
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?,mask:MacroScrollViewMask) {
        
        ctrlsArray = [UniversalLineViewController]()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
        backItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action:"nvBackButtonAction:")
        
        
        if mask == MacroScrollViewMask.OIL{
            masks = mask
            let universalVC = UniversalLineViewController(nibName: "UniversalLineViewController", bundle: nil, des: "xxxxxxxxxxxx", name: "oil ", symbol: "oil", level: "High")
            
            ctrlsArray.append(universalVC)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nvBackButtonAction(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
