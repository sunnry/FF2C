//
//  PortFolioTableViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/11.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit



class PortFolioTableViewController :UITableViewController{
    
    var itemArray:[String] = ["隐私和条款","报告Bug","点赞","退出","empty"]
    var itemImgArray:[String] = ["term","bugs","love","exit","exit"]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "PortFolioHoldCell", bundle: nil), forCellReuseIdentifier: "PortFolioHoldCell")
        
        self.tableView.registerNib(UINib(nibName: "AddPortFolioCell", bundle: nil), forCellReuseIdentifier: "AddPortFolioCell")
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return AppConfiguration.PortFolioTableViewConfig.SectionNum
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConfiguration.PortFolioTableViewConfig.DefaultTotalCellNum
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)-> CGFloat {
        if indexPath.row == AppConfiguration.PortFolioTableViewConfig.FirstRow{
            return AppConfiguration.PortFolioTableViewConfig.AddPortFolioRowHeight
        }
        else{
            return AppConfiguration.PortFolioTableViewConfig.RowHeight
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == AppConfiguration.PortFolioTableViewConfig.FirstRow {
            let cell:AddPortFolioCell = tableView.dequeueReusableCellWithIdentifier("AddPortFolioCell") as! AddPortFolioCell
            return cell
        }
        else{
            let cell:PortFolioHoldCell = tableView.dequeueReusableCellWithIdentifier("PortFolioHoldCell") as! PortFolioHoldCell
        
            cell.percentage.layer.cornerRadius = AppConfiguration.PortFolioTableViewConfig.LabelPercentageCornerRadius
            cell.percentage.clipsToBounds = true
            return cell
        }
        
    }
    
    
    
}
