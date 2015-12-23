//
//  PortFolioTableViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/11.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit


protocol quoteDelegate:class{
    func didShowQuoteController()
    func updatePortFolioWithNewQuote(quote:SimpleQuote)
}


class PortFolioTableViewController :UITableViewController,quoteDelegate{
    
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
            cell.delegate = self
            return cell
        }
        else{
            let cell:PortFolioHoldCell = tableView.dequeueReusableCellWithIdentifier("PortFolioHoldCell") as! PortFolioHoldCell
            cell.percentage.layer.cornerRadius = AppConfiguration.PortFolioTableViewConfig.LabelPercentageCornerRadius
            cell.percentage.clipsToBounds = true
            
            //the first cell is used to addPortFolio button and delete button, so we must delete 1 before index item
            
            if indexPath.row <= Quote.sharedInstance.count(){
                let index:Int = indexPath.row - 1
                if let s = Quote.sharedInstance.indexItem(index){
                    cell.symbol.text = s.symbol?.uppercaseString
                    cell.price.text = s.lastTradePrice
                    cell.percentage.text = s.percentage
                }
                
                
            }
        
            return cell
        }
        
    }
    
    func didShowQuoteController() {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let quoteVC = storyboard.instantiateViewControllerWithIdentifier("searchVC")
        
        let searchSymbolTabVC = searchSymbolTableViewController(nibName: "searchSymbolTableView", bundle: nil)
        
        searchSymbolTabVC.delegate = self

        let nvController:UINavigationController = UINavigationController(rootViewController: searchSymbolTabVC)
        nvController.navigationBar.barStyle = UIBarStyle.Default
        
        self.presentViewController(nvController, animated: true, completion: nil)
    }
    
    func updatePortFolioWithNewQuote(quote:SimpleQuote) {
        //print("get:\(quote.name)")
        
        var detail = SymbolDetail()
        detail.symbol = quote.symbol
        detail.Name = quote.name
        detail.dayChange = quote.change
        detail.lastTradePrice = quote.lastTradePrice
        
        Quote.sharedInstance.addSymbol(detail)
        
        self.tableView.reloadData()
    }
    
    
    
}
