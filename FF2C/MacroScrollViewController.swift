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
    case USA
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
    
    /*https://www.quandl.com/data/BKRHUGHES/OILGAS_SPLIT-Baker-Hughes-Oil-Gas-Split*/
    struct BAKE_OIL_SPLIT{
        static let url = "https://www.quandl.com/api/v3/datasets/BKRHUGHES/OILGAS_SPLIT.json"
        static let name = "贝克休斯北美油井数量"
        static let level = "High"
        static let source = DataSourceType.quandl_oil_baker_oil_split
    }
    
    /*https://www.quandl.com/data/ICE/GZ2018-Gas-Oil-Futures-December-2018-GZ2018*/
    struct GAS_OIL_FUTURE_OPEN_2018{
        static let url = "https://www.quandl.com/api/v3/datasets/ICE/GZ2018.json"
        static let name = "2018油气期货新开合约"
        static let level = "High"
        static let source = DataSourceType.quandl_gas_oil_future_open_2018
    }
    
    /*https://www.quandl.com/data/WORLDBANK/CHN_FP_CPI_TOTL_ZG-China-Inflation-consumer-prices-annual?utm_medium=graph&utm_source=quandl*/
    struct CHINA_CPI{
        static let url = "https://www.quandl.com/api/v3/datasets/WORLDBANK/CHN_FP_CPI_TOTL_ZG.json"
        static let name = "中国CPI指数"
        static let level = "High"
        static let source = DataSourceType.quandl_china_cpi_index
    }
    
    /*https://www.quandl.com/data/STATCHINA/H0809-Outstanding-of-Debts-of-Central-Government*/
    struct CHINA_EXTERNAL_DEBT{
        static let url = "https://www.quandl.com/api/v3/datasets/STATCHINA/H0809.json"
        static let name = "中国对外债务"
        static let level = "Normal"
        static let source = DataSourceType.quandl_china_external_debt
    }
    
    /*https://www.quandl.com/data/RATEINF/INFLATION_USA-Inflation-YOY-USA*/
    struct USA_INFLATION_RATE{
        static let url = "https://www.quandl.com/api/v3/datasets/RATEINF/INFLATION_USA.json"
        static let name = "美国通胀率"
        static let level = "High"
        static let source = DataSourceType.quandl_usa_inflation_rate
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
            
            let bakerVC = UniversalLineViewController(nibName: "UniversalLineViewController", bundle: nil, des: nil, name: UniversalParams.BAKE_OIL_SPLIT.name, symbol: nil, level: UniversalParams.BAKE_OIL_SPLIT.level,url: UniversalParams.BAKE_OIL_SPLIT.url,time:.TenYear ,source: UniversalParams.BAKE_OIL_SPLIT.source)
            
            ctrlsArray.append(bakerVC)
            
            let oil_futureVC = UniversalLineViewController(nibName: "UniversalLineViewController", bundle: nil, des: nil, name: UniversalParams.GAS_OIL_FUTURE_OPEN_2018.name, symbol: nil, level: UniversalParams.GAS_OIL_FUTURE_OPEN_2018.level,url: UniversalParams.GAS_OIL_FUTURE_OPEN_2018.url,time:.TwoYear ,source: UniversalParams.GAS_OIL_FUTURE_OPEN_2018.source)
            
            ctrlsArray.append(oil_futureVC)
            
        }else if mask == MacroScrollViewMask.CHINA{
            masks = mask
            
            let cpiVC = UniversalLineViewController(nibName: "UniversalLineViewController", bundle: nil, des: nil, name: UniversalParams.CHINA_CPI.name, symbol: nil, level: UniversalParams.CHINA_CPI.level,url: UniversalParams.CHINA_CPI.url,time:.TenYear ,source: UniversalParams.CHINA_CPI.source)
            
            ctrlsArray.append(cpiVC)
            
            let debtVC = UniversalLineViewController(nibName: "UniversalLineViewController", bundle: nil, des: nil, name: UniversalParams.CHINA_EXTERNAL_DEBT.name, symbol: nil, level: UniversalParams.CHINA_EXTERNAL_DEBT.level,url: UniversalParams.CHINA_EXTERNAL_DEBT.url,time:.TenYear ,source: UniversalParams.CHINA_EXTERNAL_DEBT.source)
            
            ctrlsArray.append(debtVC)
        }else if mask == MacroScrollViewMask.USA{
            masks = mask

            let usaInflationVC = UniversalLineViewController(nibName: "UniversalLineViewController", bundle: nil, des: nil, name: UniversalParams.USA_INFLATION_RATE.name, symbol: nil, level: UniversalParams.USA_INFLATION_RATE.level,url: UniversalParams.USA_INFLATION_RATE.url,time:.TenYear ,source: UniversalParams.USA_INFLATION_RATE.source)
            
            ctrlsArray.append(usaInflationVC)
            
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nvBackButtonAction(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
