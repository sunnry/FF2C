//
//  ViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/7.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pageMenu :CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "菜鸟财经"
        self.navigationController?.navigationBar.barTintColor = UIColor(red:20.0/255.0,green:20.0/255.0,blue:20.0/255.0,alpha:1.0)
        
        
        
        
        var ctrlArray :[UIViewController] = []
        
        let folioCtrl:UITableViewController = UITableViewController(nibName: nil, bundle: nil)
        folioCtrl.title = "持仓"
        ctrlArray.append(folioCtrl)
        
        let settingCtrl:SettingTableViewController = SettingTableViewController(nibName: "SettingTableViewController", bundle: nil)
        settingCtrl.title = "设置"
        ctrlArray.append(settingCtrl)
        
        let params:[CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red:20.0/255.0,green:20.0/255.0,blue:20.0/255.0,alpha:1.0))
        ]
        
        
        
        
        pageMenu = CAPSPageMenu(viewControllers: ctrlArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: params)
        
        self.view.addSubview(pageMenu!.view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

