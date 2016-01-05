//
//  Quote.swift
//  FF2C
//
//  Created by sunny sun on 15/12/21.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Charts

extension Float{
    func format(f:String)->String{
        return NSString(format: "%\(f)f", self) as String
    }
}

protocol qLineChartUpdate{
    func updateLineChartData(data : LineChartData?)
}

protocol qDelegate {
    func addSymbol(s:SymbolDetail)
    func delSymbol(s:String)
    func updateSymbol(name:String,s:SymbolDetail)
    func count()->Int
    func indexItem(index:Int)->SymbolDetail?
}

struct SymbolDetail{
    var symbol:String?
    var Name:String?
    var daysHigh:String?
    var daysLLow:String?
    var yearHigh:String?
    var yearLow:String?
    var dayChange:String?
    var averageDailyVolume:String?
    var lastTradePrice:String?
    
    var percentage:String?{
        get{
            if let price = lastTradePrice{
                if let change = dayChange{
                    
                    let priceFloat = Float(price)!
                    let changeFloat = Float(change)!
                    if priceFloat == 0.0{
                        return "N/A"
                    }
                    
                    let percentFloat = (changeFloat/(priceFloat + changeFloat))*100
                    
                    let percentString = percentFloat.format(".2") + "%"
                    
                    return percentString
                }
            }
            return "N/A"
        }
    }
    
    
}


class Quote:qDelegate {

    var chartDelegate:AnyObject?
    var delegateType:String?
    
    var symbolArray:[SymbolDetail]!
    
    var urlString:URLStringConvertible!
    
    var monthAgo:String?
    
    var today:String?
    
    static let sharedInstance:Quote = {
       return Quote()
    }()
    
    init(){
        
        today = caculateToday()
        
        monthAgo = caculateMonthAgoFromToday()
        
        urlString = "https://query.yahooapis.com/v1/public/yql"
        
        symbolArray = Array<SymbolDetail>()
        
        let editCell:SymbolDetail = SymbolDetail(symbol: "EDITCELL", Name: nil, daysHigh: nil, daysLLow: nil, yearHigh: nil, yearLow: nil, dayChange: nil, averageDailyVolume: nil, lastTradePrice: nil)
        
        symbolArray.append(editCell)
    }
    
    //return true = exit, return false = not existed
    private func symbolExited(symbol:String)->Bool{
        
        for item in symbolArray{
            if item.symbol?.uppercaseString == symbol{
                return true
            }
        }
        return false
        
    }
    
    func indexItem(index: Int) -> SymbolDetail? {
        if index >= symbolArray.count {
            return nil
        }
        
        return symbolArray[index]
    }
    
    func searchItem(symbol:String)->SymbolDetail?{
        for i in symbolArray{
            if i.symbol?.uppercaseString == symbol.uppercaseString{
                return i
            }
        }
        return nil
    }
    
    
    func count() -> Int {
        return symbolArray.count
    }
    
    func addSymbol(s: SymbolDetail) {
        if let symbol = s.symbol{
            if symbolExited(symbol) == false{
                symbolArray.append(s)
            }
        }
    }
    
    func delSymbol(s: String) {
        if symbolExited(s) == true{
            for i in 0...(symbolArray.count-1){
                if symbolArray[i].symbol?.uppercaseString == s{
                    symbolArray.removeAtIndex(i)
                    break
                }
            }
            
        }
    }
    
    func updateSymbol(name: String, s: SymbolDetail) {
        //symbolArray?.updateValue(s, forKey: name)
    }
    
    func caculateToday()->String{
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.stringFromDate(NSDate())
        
        return dateString
    }
    
    func caculateMonthAgoFromToday()->String?{
        
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([NSCalendarUnit.Year,NSCalendarUnit.Month, NSCalendarUnit.Day,NSCalendarUnit.Hour], fromDate: NSDate())
        
        components.month = components.month - 1
        
        let date = calendar.dateFromComponents(components)
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let d = date{
            let dateString = formatter.stringFromDate(d)
            return dateString
        }
        
        return nil
    }
    
    func dealHistoryChartJsonData(json:JSON,symbol:String){

        var xVar:[NSObject]? = [NSObject]()
        var yVals:[ChartDataEntry]? = [ChartDataEntry]()
        
        let quoteJson = json["query"]["results"]["quote"]
        
        let count = quoteJson.count
        //print(quoteJson.count)
        
        var c = count - 1
        var index:Int = 0
        while c >= 0{
            let jsonItem = quoteJson[c]
            if let date = jsonItem["Date"].string{
                xVar?.append(date)
                    
                if let value = jsonItem["Close"].string{
                    if let valueD = Double(value){
                        yVals?.append(ChartDataEntry(value: valueD, xIndex: index))
                        index = index + 1
                        c = c - 1
                    }
                }
            }
        }
        
        let dataSet:LineChartDataSet = LineChartDataSet(yVals: yVals)
        dataSet.label = symbol
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawCirclesEnabled = false
        
        let data:LineChartData = LineChartData(xVals: xVar, dataSet: dataSet)
        
        data.setValueFont(UIFont.systemFontOfSize(5.0))
        
        data.setDrawValues(true)
        
        if delegateType == "LineChartView"{
            if let d = chartDelegate as? QuoteLineViewController{
                d.updateLineChartData(data)
            }
        }
        
    }
    
    func requestOneMonthChart(symbol:String,o:AnyObject,type:String){
        
        chartDelegate = o
        delegateType = type
        
        if let t = today{
            if let agoMonth = monthAgo{
                let sql:String = "select * from yahoo.finance.historicaldata where symbol = \"" + symbol + "\" and startDate=\"" + agoMonth + "\" and endDate=\"" + t + "\""
                
                let params:[String:AnyObject]? = ["q":sql,"format":"json","diagnostics":"true","env":"store://datatables.org/alltableswithkeys"]
                
                Alamofire.request(.GET, urlString, parameters: params).responseJSON{response in
                    switch response.result{
                    case .Success(let _):
                        if let value = response.result.value{
                            let json = JSON(value)
                            self.dealHistoryChartJsonData(json, symbol: symbol)
                            print("\(json)")
                            
                        }
                        
                    case .Failure(let error):
                        print("\(error)")
                    }
                }
                
            }
        }
    }
    
}
