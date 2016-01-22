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

struct UniversalParams{
    struct EIA_WEEKLY_OIL{
        static let url = "https://www.quandl.com/api/v3/datasets/FLYINGSQRL/WEEKLY_US_CRUDE_OIL_STOCKS.json"
        static let name = "EIA每周库存周报"
        static let level = "High"
        static let source = DataSourceType.quandl_oil_weekly_stock_report
    
    }
    
    struct OPEC_OIL_PRICE{
        static let url = "https://www.quandl.com/api/v3/datasets/OPEC/ORB.json"
        static let name = "OPEC原油均价"
        static let level = "Normal"
        static let source = DataSourceType.quandl_oil_opec_price
    }
}


class MacroScrollViewController: UIViewController,UIScrollViewDelegate {
    
    var backItem:UIBarButtonItem?
    var masks:MacroScrollViewMask?
    var ctrl:UniversalLineViewController?
    
    var ctrlsArray:[UniversalLineViewController]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let count = ctrlsArray.count
        
        let xoffset:CGFloat = 0
        var yoffset:CGFloat = 0
        if count > 0{
            for ctrl in ctrlsArray{
                let point = CGPoint(x: xoffset, y: yoffset)
                let size = CGSize(width: self.view.frame.width, height: (self.view.frame.height/5)*3)
                
                ctrl.view.frame = CGRect(origin: point, size: size)
                
                yoffset = ctrl.view.frame.height + yoffset
            }
        }
        
        if let v = self.view as? UIScrollView{
            v.directionalLockEnabled = true
            v.showsHorizontalScrollIndicator = true
            let newSize = CGSizeMake(self.view.frame.width, yoffset)
            v.contentSize = newSize
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
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
            
            let universalVC = UniversalLineViewController(nibName: "UniversalLineViewController", bundle: nil, des: nil, name: UniversalParams.EIA_WEEKLY_OIL.name, symbol: nil, level: UniversalParams.EIA_WEEKLY_OIL.level,url: UniversalParams.EIA_WEEKLY_OIL.url,time:.TwoYear,source: UniversalParams.EIA_WEEKLY_OIL.source)
            
            ctrlsArray.append(universalVC)


            let openOilPriceVC = UniversalLineViewController(nibName: "UniversalLineViewController", bundle: nil, des: nil, name: UniversalParams.OPEC_OIL_PRICE.name, symbol: nil, level: UniversalParams.OPEC_OIL_PRICE.level,url: UniversalParams.OPEC_OIL_PRICE.url,time:.TwoYear,source: UniversalParams.OPEC_OIL_PRICE.source)
            
            ctrlsArray.append(openOilPriceVC)
            
            
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nvBackButtonAction(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
