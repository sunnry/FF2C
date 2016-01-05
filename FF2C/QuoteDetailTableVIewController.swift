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
    
    var q:SymbolDetail?
    
    var lineViewContrller:QuoteLineViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.tableView.registerNib(UINib(nibName: "QuoteDetailNameCell", bundle: nil), forCellReuseIdentifier: "QuoteDetailNameCell")
        
        self.tableView.registerNib(UINib(nibName: "QuoteDetailPriceChangeCell", bundle: nil), forCellReuseIdentifier: "QuoteDetailPriceChangeCell")
        
        self.tableView.registerNib(UINib(nibName:"QuoteDetailCommonCell",bundle: nil), forCellReuseIdentifier: "QuoteDetailCommonCell")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.navigationItem.leftBarButtonItem = backItem
        
        lineViewContrller = QuoteLineViewController(nibName: "QuoteLineViewController", bundle: nil, symbol: self.symbol)
        if let s = symbol{
            q = Quote.sharedInstance.searchItem(s)
        }
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
        return 10
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
            
            if let n = q?.Name{
                cell.smallName.text = n
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
            
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.secondRow{
            let cell:QuoteDetailPriceChangeCell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailPriceChangeCell") as! QuoteDetailPriceChangeCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if let p = q?.lastTradePrice{
                cell.currentPrice.text = p
            }
            
            if let c = q?.dayChange{
                cell.priceChange.text = c
            }
            
            return cell
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.lineTableRow{
            let cell:UITableViewCell = UITableViewCell()
            
            if let ctrl = lineViewContrller{
                cell.contentView.addSubview(ctrl.view)
                self.addChildViewController(ctrl)
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.DayRangeRow{
            let cell:QuoteDetailCommonCell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailCommonCell") as! QuoteDetailCommonCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.leftLabel.text = "Day Range:"
            if let dr = q?.dayChange{
                cell.rightLabel.text = dr
            }
            
            return cell
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.VolumeRow{
            let cell:QuoteDetailCommonCell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailCommonCell") as! QuoteDetailCommonCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.leftLabel.text = "Volume:"
            if let v = q?.averageDailyVolume{
                cell.rightLabel.text = v
            }
            
            return cell
            
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.WeeksRow{
            let cell:QuoteDetailCommonCell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailCommonCell") as! QuoteDetailCommonCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.leftLabel.text = "52 Weeks:"
            if let wl = q?.yearLow{
                if let wh = q?.yearHigh{
                    cell.rightLabel.text = wl + " - " + wh
                }
            }
            
            return cell
            
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.PERow{
            let cell:QuoteDetailCommonCell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailCommonCell") as! QuoteDetailCommonCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.leftLabel.text = "PE:"
            
            return cell
            
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.YieldRow{
            let cell:QuoteDetailCommonCell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailCommonCell") as! QuoteDetailCommonCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.leftLabel.text = "Yield:"
            
            return cell
            
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.MarketCapRow{
            let cell:QuoteDetailCommonCell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailCommonCell") as! QuoteDetailCommonCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.leftLabel.text = "Market Cap:"
            
            return cell
            
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.EPSRow{
            let cell:QuoteDetailCommonCell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailCommonCell") as! QuoteDetailCommonCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.leftLabel.text = "EPS:"
            
            return cell
            
        }
        else{
            let cell:UITableViewCell = UITableViewCell()
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.FirstRow{
            return AppConfiguration.QuoteDetailTableViewConfig.FirstRowHeight
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.secondRow{
            return AppConfiguration.QuoteDetailTableViewConfig.secondRowHeight
        }else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.lineTableRow{
            return AppConfiguration.QuoteDetailTableViewConfig.lineTableHeight
        }
        else{
            return AppConfiguration.QuoteDetailTableViewConfig.defaultRowHeight
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.lineTableRow{
            //print("\(cell.contentView.frame)")
            if let ctrl = lineViewContrller{
                ctrl.view.frame = cell.contentView.frame
            }
        }
        else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.FirstRow{
            if let c = cell as? QuoteDetailNameCell{
                c.reformUnderline(self.view.frame.width)
            }
        }
        else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.secondRow{
            if let c = cell as? QuoteDetailPriceChangeCell{
                c.reformUnderline(self.view.frame.width)
            }
        }
        else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.DayRangeRow{
            if let c = cell as? QuoteDetailCommonCell{
                c.reformUnderline(self.view.frame.width)
            }
        }
        else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.VolumeRow{
            if let c = cell as? QuoteDetailCommonCell{
                c.reformUnderline(self.view.frame.width)
            }
        }
        else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.WeeksRow{
            if let c = cell as? QuoteDetailCommonCell{
                c.reformUnderline(self.view.frame.width)
            }
        }
        else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.YieldRow{
            if let c = cell as? QuoteDetailCommonCell{
                c.reformUnderline(self.view.frame.width)
            }
        }
        else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.PERow{
            if let c = cell as? QuoteDetailCommonCell{
                c.reformUnderline(self.view.frame.width)
            }
        }
        else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.MarketCapRow{
            if let c = cell as? QuoteDetailCommonCell{
                c.reformUnderline(self.view.frame.width)
            }
        }
        else if indexPath.row == AppConfiguration.QuoteDetailTableViewConfig.EPSRow{
            if let c = cell as? QuoteDetailCommonCell{
                c.reformUnderline(self.view.frame.width)
            }
        }
    }
}