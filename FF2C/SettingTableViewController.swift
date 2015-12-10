//
//  SettingTableViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/9.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit

class SettingTableViewController :UITableViewController{
    
    var itemArray:[String] = ["隐私和条款","报告Bug","点赞","退出","empty"]
    var itemImgArray:[String] = ["term","bugs","love","exit","exit"]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return AppConfiguration.SettingTableViewConfig.SectionNum
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConfiguration.SettingTableViewConfig.TotoalCellNum
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)-> CGFloat {
        return AppConfiguration.SettingTableViewConfig.RowHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell:UITableViewCell = UITableViewCell()
        
        let cell:SettingTableViewCell = tableView.dequeueReusableCellWithIdentifier("SettingTableViewCell") as! SettingTableViewCell
        
        cell.label.text = itemArray[indexPath.row]
        cell.imgView.image = UIImage(named: itemImgArray[indexPath.row])
        
        
        return cell
    }
    
    
    
}
