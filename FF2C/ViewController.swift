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
    
    var quote:Quote?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quote = Quote()
        
        self.title = "菜鸟财经"
        self.navigationController?.navigationBar.barTintColor = UIColor(red:20.0/255.0,green:20.0/255.0,blue:20.0/255.0,alpha:1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.orangeColor(),NSFontAttributeName:UIFont(name: "Heiti SC", size: 24)!]
        
        
        
        
        
        var ctrlArray :[UIViewController] = []
        
        let folioCtrl:UITableViewController = PortFolioTableViewController(nibName: "PortFolioTableViewController", bundle: nil)
        folioCtrl.title = "持仓"
        ctrlArray.append(folioCtrl)
        
        let settingCtrl:SettingTableViewController = SettingTableViewController(nibName: "SettingTableViewController", bundle: nil)
        settingCtrl.title = "设置"
        ctrlArray.append(settingCtrl)
        
        let params:[CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red:20.0/255.0,green:20.0/255.0,blue:20.0/255.0,alpha:1.0)),
            .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.orangeColor()),
            .AddBottomMenuHairline(false),
            //.MenuItemFont(UIFont(name: "HelveticaNeue", size: 24.0)!),
            .MenuItemFont(UIFont(name: "Heiti SC", size: 24.0)!),
            .MenuHeight(50.0),
            .SelectionIndicatorHeight(3.0),
            .MenuItemWidthBasedOnTitleTextWidth(true),
            .SelectedMenuItemLabelColor(UIColor.orangeColor())
        ]
        
        
        
        
        pageMenu = CAPSPageMenu(viewControllers: ctrlArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: params)
        
        self.view.addSubview(pageMenu!.view)
        
        self.addChildViewController(pageMenu!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if you use segue, you can use this function to transfer user define data to other viewController
    }


}

