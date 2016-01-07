//
//  searchSymbolTableViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/17.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct SimpleQuote {
    var name:String
    var symbol:String
    var lastTradePrice:String
    var change:String
}

class searchSymbolTableViewController: UITableViewController,UISearchBarDelegate {
    
    var searchSymbolBar:UISearchBarWithActivityIndicator?
    var resultArray:[SymbolDetail]?
    var delegate:quoteDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        searchSymbolBar = UISearchBarWithActivityIndicator()
        searchSymbolBar?.showsCancelButton = true
        searchSymbolBar?.delegate = self
        
        resultArray = Array<SymbolDetail>()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "searchSymbolCell", bundle: nil), forCellReuseIdentifier: "searchSymbolCell")

        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.navigationItem.titleView = searchSymbolBar
        searchSymbolBar?.placeholder = "请输入股票代码"
        searchSymbolBar?.becomeFirstResponder()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return AppConfiguration.SearchSymbolTableViewConfig.SectionNum
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConfiguration.SearchSymbolTableViewConfig.DefaultTotoalCellNum
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AppConfiguration.SearchSymbolTableViewConfig.RowHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell()
        
        if let count = resultArray?.count{
            if count > 0 && indexPath.row < count {
                if let q = resultArray?[indexPath.row]{
                        cell.textLabel?.text = q.Name
                }
            }
        }
        
        return cell
    }
    
    //when one row selected
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row >= resultArray?.count{
            return
        }
        else{
            if let s = resultArray?[indexPath.row]{
                self.delegate?.updatePortFolioWithNewQuote(s)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchSymbolBar?.startActivity()
        requestSymbol(searchText)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dealJson(json:JSON){
        searchSymbolBar?.finishActivity()
        
        resultArray?.removeAll()
        
        if let name = json["query"]["results"]["quote"]["Name"].string{
            if let symbol = json["query"]["results"]["quote"]["symbol"].string{
                var t = SymbolDetail()
                t.Name = name
                t.symbol = symbol
                
                if let price = json["query"]["results"]["quote"]["LastTradePriceOnly"].string{
                    t.lastTradePrice = price
                }else{
                    t.lastTradePrice = "N/A"
                }
                
                if let change = json["query"]["results"]["quote"]["Change"].string{
                    t.dayChange = change
                }else{
                    t.dayChange = "N/A"
                }
                
                if let dh = json["query"]["results"]["quote"]["DaysHigh"].string{
                    t.daysHigh = dh
                }else{
                    t.daysHigh = "N/A"
                }
                
                if let dl = json["query"]["results"]["quote"]["DaysLow"].string{
                    t.daysLLow = dl
                }else{
                    t.daysLLow = "N/A"
                }
                
                if let adv = json["query"]["results"]["quote"]["AverageDailyVolume"].string{
                    t.averageDailyVolume = adv
                }else{
                    t.averageDailyVolume = "N/A"
                }
                
                if let yh = json["query"]["results"]["quote"]["YearHigh"].string{
                    t.yearHigh = yh
                }else{
                    t.yearHigh = "N/A"
                }
                
                if let yl = json["query"]["results"]["quote"]["YearLow"].string{
                    t.yearLow = yl
                }else{
                    t.yearLow = "N/A"
                }
                
                if let mc = json["query"]["results"]["quote"]["MarketCapitalization"].string{
                    t.marketCap = mc
                }else{
                    t.marketCap = "N/A"
                }
                
                resultArray?.append(t)
                
            }else{
                print("can not parse symbol from result")
            }
        }else{
            print("can not parse name from result")
        }
        
        self.tableView.reloadData()
    }
    
    func requestSymbol(symbol:String){
        let symbol:String = symbol
        let urlString:URLStringConvertible = "https://query.yahooapis.com/v1/public/yql"
        let sql:String = "select * from yahoo.finance.quote where symbol in (\"" + symbol + "\")"
        
        let params:[String:AnyObject]? = ["q":sql,"format":"json","diagnostics":"true","env":"store://datatables.org/alltableswithkeys"]
        
        Alamofire.request(.GET, urlString, parameters: params).responseJSON{response in
            switch response.result{
            case .Success(let _):
                if let value = response.result.value{
                    let json = JSON(value)
                    //print(json)
                    self.dealJson(json)
                }
                
            case .Failure(let error):
                print("\(error)")
            }
        }
    }
}
