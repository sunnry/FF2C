//
//  QuoteDetailTableVIewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/26.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit


class QuoteDetailTableViewController: UITableViewController {
    
    var backItem:UIBarButtonItem?
    
    var symbol:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.tableView.registerNib(UINib(nibName: "QuoteDetailNameCell", bundle: nil), forCellReuseIdentifier: "QuoteDetailNameCell")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, symbol:String) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.symbol = symbol
        
        backItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action:"nvBackButtonAction:")
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nvBackButtonAction(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.FirstRow{
            let cell:QuoteDetailNameCell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailNameCell") as! QuoteDetailNameCell
        
            if let s = self.symbol {
                cell.bigSymbol.text = s
            }
            
            return cell
            
        }else{
            let cell:UITableViewCell = UITableViewCell()
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.FirstRow{
            return AppConfiguration.QuoteDetailTableViewConfig.FirstRowHeight
        }
        else{
            return AppConfiguration.QuoteDetailTableViewConfig.defaultRowHeight
        }
    }    
}