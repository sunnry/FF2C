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
        return Quote.sharedInstance.count()
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
            
            //the first cell is used to addPortFolio button, but i have ocupied it with EDITCELL
            
            if indexPath.row <= Quote.sharedInstance.count(){
                let index:Int = indexPath.row
                if let s = Quote.sharedInstance.indexItem(index){
                    cell.symbol.text = s.symbol?.uppercaseString
                    cell.price.text = s.lastTradePrice
                    cell.percentage.text = s.percentage
                }
                
                
            }
        
            return cell
        }
        
    }
    
    //enable delete tableview item when user slide cell after return true
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            //because the first cell used for Portfolio edit, so portfolio index start from 1
            if let cell:PortFolioHoldCell = tableView.cellForRowAtIndexPath(indexPath) as? PortFolioHoldCell{
                if let symbol = cell.symbol.text{
                    Quote.sharedInstance.delSymbol(symbol)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
                
            }
            
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == AppConfiguration.PortFolioTableViewConfig.FirstRow{
            return
        }
        
        if let cell:PortFolioHoldCell = tableView.cellForRowAtIndexPath(indexPath) as? PortFolioHoldCell{
            if let symbol = cell.symbol.text{
                let quoteDetailScrollCtrl:QuoteDetailScrollViewController = QuoteDetailScrollViewController(nibName: "QuoteDetailScrollViewController", bundle: nil, symbol: symbol)
                
                let nvCtrl:UINavigationController = UINavigationController(rootViewController: quoteDetailScrollCtrl)
                
                nvCtrl.navigationBar.barStyle = UIBarStyle.Default
                
                self.presentViewController(nvCtrl, animated: true, completion: nil)
            }
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
