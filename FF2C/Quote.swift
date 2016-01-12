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

protocol PortFolioUpdate{
    func updateAllPortFolio(update:Bool)
}

protocol qDelegate {
    func addSymbol(s:SymbolDetail)
    func delSymbol(s:String)
    func updateSymbol(s:SymbolDetail)
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
    var marketCap:String?
    
    var percentage:String?{
        get{
            if let price = lastTradePrice{
                if let change = dayChange{
                    
                    if change == "N/A"{
                        return change
                    }
                    
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
    var chartDelegateType:String?
    
    var delegate:AnyObject?
    var delegateType:String?
    
    var symbolArray:[SymbolDetail]!
    
    var urlString:URLStringConvertible!
    
    var monthAgo:String?
    
    var today:String?
    
    var fiveDay:String?
    
    var threeMonthAgo:String?
   
    var oneYear:String?
    
    var twoYear:String?
    
    var fiveYear:String?
    
    var xmlParser:SymbolXmlParser?
    
    static let sharedInstance:Quote = {
       return Quote()
    }()
    
    init(){
        xmlParser = SymbolXmlParser()
        
        today = caculateToday()
        
        monthAgo = caculateMonthAgoFromToday()
        
        fiveDay = caculate5Day()
        
        threeMonthAgo = caculate3MonthAgo()
        
        oneYear = caculate1YAgo()
        
        twoYear = caculate2YAgo()
        
        fiveYear = caculate5YAgo()
        
        urlString = "https://query.yahooapis.com/v1/public/yql"
        
        symbolArray = Array<SymbolDetail>()
        
        let editCell:SymbolDetail = SymbolDetail(symbol: "EDITCELL", Name: nil, daysHigh: nil, daysLLow: nil, yearHigh: nil, yearLow: nil, dayChange: nil, averageDailyVolume: nil, lastTradePrice: nil, marketCap:nil )
        
        symbolArray.append(editCell)
        
        if let loadArray = xmlParser?.loadXmlResources(){
            for item in loadArray{
                symbolArray.append(item)
            }
        }
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
        xmlParser?.saveXmlResources()
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
        xmlParser?.saveXmlResources()
    }
    
    func updateSymbol(s: SymbolDetail) {
        if let symbol = s.symbol{
            if symbolExited(symbol) == true{
                for i in 0...(symbolArray.count - 1){
                    if symbolArray[i].symbol?.uppercaseString == symbol.uppercaseString{
                        symbolArray[i].dayChange = s.dayChange
                        symbolArray[i].daysHigh = s.daysHigh
                        symbolArray[i].daysLLow = s.daysLLow
                        symbolArray[i].lastTradePrice = s.lastTradePrice
                        symbolArray[i].marketCap = s.marketCap
                        symbolArray[i].yearHigh = s.yearHigh
                        symbolArray[i].yearLow = s.yearLow
                        symbolArray[i].averageDailyVolume = s.averageDailyVolume
                    }
                }
            }
        }
        //symbolArray?.updateValue(s, forKey: name)
    }
    
    func caculateToday()->String{
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.stringFromDate(NSDate())
        
        return dateString
    }
    
    func caculate5Day()->String?{
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([NSCalendarUnit.Year,NSCalendarUnit.Month, NSCalendarUnit.Day,NSCalendarUnit.Hour], fromDate: NSDate())
        
        components.day = components.day - 7
        
        let date = calendar.dateFromComponents(components)
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let d = date{
            let dateString = formatter.stringFromDate(d)
            //print("5D caculate result : \(dateString)")
            return dateString
        }
        
        return nil
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

    func caculate3MonthAgo()->String?{
        
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([NSCalendarUnit.Year,NSCalendarUnit.Month, NSCalendarUnit.Day,NSCalendarUnit.Hour], fromDate: NSDate())
        
        components.month = components.month - 3
        
        let date = calendar.dateFromComponents(components)
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let d = date{
            let dateString = formatter.stringFromDate(d)
            //print("3 month caculate : \(dateString)")
            return dateString
        }
        
        return nil
    }

    func caculate1YAgo()->String?{
        
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([NSCalendarUnit.Year,NSCalendarUnit.Month, NSCalendarUnit.Day,NSCalendarUnit.Hour], fromDate: NSDate())
        
        components.year = components.year - 1
        
        let date = calendar.dateFromComponents(components)
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let d = date{
            let dateString = formatter.stringFromDate(d)
            //print("1Y = \(dateString)")
            return dateString
        }
        return nil
    }
    
    
    func caculate2YAgo()->String?{
        
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([NSCalendarUnit.Year,NSCalendarUnit.Month, NSCalendarUnit.Day,NSCalendarUnit.Hour], fromDate: NSDate())
        
        components.year = components.year - 2
        
        let date = calendar.dateFromComponents(components)
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let d = date{
            let dateString = formatter.stringFromDate(d)
            //print("2Y = \(dateString)")
            return dateString
        }
        return nil
    }
    
    func caculate5YAgo()->String?{
        
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([NSCalendarUnit.Year,NSCalendarUnit.Month, NSCalendarUnit.Day,NSCalendarUnit.Hour], fromDate: NSDate())
        
        components.year = components.year - 5
        
        let date = calendar.dateFromComponents(components)
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let d = date{
            let dateString = formatter.stringFromDate(d)
            //print("5Y = \(dateString)")
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
        dataSet.drawFilledEnabled = true
        
        let data:LineChartData = LineChartData(xVals: xVar, dataSet: dataSet)
        
        data.setValueFont(UIFont.systemFontOfSize(5.0))
        
        data.setDrawValues(true)
        
        if chartDelegateType == "LineChartView"{
            if let d = chartDelegate as? QuoteLineViewController{
                d.updateLineChartData(data)
            }
        }
        
    }
    
    
    func request5DChartData(symbol:String,o:AnyObject,type:String){
        chartDelegate = o
        chartDelegateType = type
        
        if let t = today{
            if let fiveD = fiveDay{
                let sql:String = "select * from yahoo.finance.historicaldata where symbol = \"" + symbol + "\" and startDate=\"" + fiveD + "\" and endDate=\"" + t + "\""
                
                let params:[String:AnyObject]? = ["q":sql,"format":"json","diagnostics":"true","env":"store://datatables.org/alltableswithkeys"]
                
                Alamofire.request(.GET, urlString, parameters: params).responseJSON{response in
                    switch response.result{
                    case .Success(let _):
                        if let value = response.result.value{
                            let json = JSON(value)
                            self.dealHistoryChartJsonData(json, symbol: symbol)
                            //print("\(json)")
                            
                        }
                        
                    case .Failure(let error):
                        print("\(error)")
                    }
                }
                
            }
        }

    }
    
    
    func requestOneMonthChartData(symbol:String,o:AnyObject,type:String){
        
        chartDelegate = o
        chartDelegateType = type
        
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
                            //print("\(json)")
                            
                        }
                        
                    case .Failure(let error):
                        print("\(error)")
                    }
                }
                
            }
        }
    }
    
    
    func request3MonthChartData(symbol:String,o:AnyObject,type:String){
        
        chartDelegate = o
        chartDelegateType = type
        
        if let t = today{
            if let threeMonth = threeMonthAgo{
                let sql:String = "select * from yahoo.finance.historicaldata where symbol = \"" + symbol + "\" and startDate=\"" + threeMonth + "\" and endDate=\"" + t + "\""
                
                let params:[String:AnyObject]? = ["q":sql,"format":"json","diagnostics":"true","env":"store://datatables.org/alltableswithkeys"]
                
                Alamofire.request(.GET, urlString, parameters: params).responseJSON{response in
                    switch response.result{
                    case .Success(let _):
                        if let value = response.result.value{
                            let json = JSON(value)
                            self.dealHistoryChartJsonData(json, symbol: symbol)
                            //print("\(json)")
                            
                        }
                        
                    case .Failure(let error):
                        print("\(error)")
                    }
                }
                
            }
        }
    }
    
    
    func request1YearChartData(symbol:String,o:AnyObject,type:String){
        
        chartDelegate = o
        chartDelegateType = type
        
        if let t = today{
            if let oneY = oneYear{
                let sql:String = "select * from yahoo.finance.historicaldata where symbol = \"" + symbol + "\" and startDate=\"" + oneY + "\" and endDate=\"" + t + "\""
                
                let params:[String:AnyObject]? = ["q":sql,"format":"json","diagnostics":"true","env":"store://datatables.org/alltableswithkeys"]
                
                Alamofire.request(.GET, urlString, parameters: params).responseJSON{response in
                    switch response.result{
                    case .Success(let _):
                        if let value = response.result.value{
                            let json = JSON(value)
                            self.dealHistoryChartJsonData(json, symbol: symbol)
                            //print("\(json)")
                            
                        }
                        
                    case .Failure(let error):
                        print("\(error)")
                    }
                }
                
            }
        }
    }
    
    
    enum WIKIStock:Int{
        case Date = 0,Open,High,Low,Close,Volume,ExDividend,SplitRatio,AdjOpen,AdjHigh,AdjLow,AdjClose,AdjVolume
        
    }
    
    func dealWIKIHistoryChartJsonData(json:JSON,symbol:String){
        
        var xVar:[NSObject]? = [NSObject]()
        var yVals:[ChartDataEntry]? = [ChartDataEntry]()
        
        let jsonData = json["dataset"]["data"]
        
        let count = jsonData.count
        
        var c = count - 1
        var index:Int = 0
        
        while c >= 0{
            let jsonItem = jsonData[c]
            //print(jsonItem)
            if let date = jsonItem[WIKIStock.Date.rawValue].string{
                xVar?.append(date)
                if let close = jsonItem[WIKIStock.AdjClose.rawValue].double{
                    yVals?.append(ChartDataEntry(value: close, xIndex: index))
                }
            }
        
            index = index + 1
            c = c - 1
        }
        
        let dataSet:LineChartDataSet = LineChartDataSet(yVals: yVals)
        dataSet.label = symbol
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.drawFilledEnabled = true
        
        let data:LineChartData = LineChartData(xVals: xVar, dataSet: dataSet)
        
        data.setValueFont(UIFont.systemFontOfSize(5.0))
        
        data.setDrawValues(true)
        
        if chartDelegateType == "LineChartView"{
            if let d = chartDelegate as? QuoteLineViewController{
                d.updateLineChartData(data)
            }
        }
    }
    
    func request2YearChartData(symbol:String,o:AnyObject,type:String){
        
        chartDelegate = o
        chartDelegateType = type
        
            if let twoY = twoYear{
                let request:String = "https://www.quandl.com/api/v3/datasets/WIKI/" + symbol + ".json"
                let params:[String:AnyObject]? = ["start_date":twoY,"api_key":"LWz5Kzq7nR8_5cewDs76"]
                
                Alamofire.request(.GET, request, parameters: params).responseJSON{response in
                    switch response.result{
                    case .Success(let _):
                        if let value = response.result.value{
                            let json = JSON(value)
                            //print("\(json)")
                            self.dealWIKIHistoryChartJsonData(json, symbol: symbol)
                            
                        }
                        
                    case .Failure(let error):
                        print("\(error)")
                    }
                }
                
            }
        
    }

    
    func request5YearChartData(symbol:String,o:AnyObject,type:String){
        
        chartDelegate = o
        chartDelegateType = type
        
        if let fiveY = fiveYear{
            let request:String = "https://www.quandl.com/api/v3/datasets/WIKI/" + symbol + ".json"
            let params:[String:AnyObject]? = ["start_date":fiveY,"api_key":"LWz5Kzq7nR8_5cewDs76"]
            
            Alamofire.request(.GET, request, parameters: params).responseJSON{response in
                switch response.result{
                case .Success(let _):
                    if let value = response.result.value{
                        let json = JSON(value)
                        self.dealWIKIHistoryChartJsonData(json, symbol: symbol)
                        //print("\(json)")
                        
                    }
                    
                case .Failure(let error):
                    print("\(error)")
                }
            }
            
        }
        
    }
    
    
    func dealSymbolsJson(json:JSON){
        let quoteJson = json["query"]["results"]["quote"]
        
        let count = quoteJson.count
        
        if count > 0{
            
            var c = count - 1
            
            while c >= 0{
                let jsonItem = quoteJson[c]
                print(jsonItem)
                
                if let name = jsonItem["Name"].string{
                    if let symbol = jsonItem["symbol"].string{
                
                        var detail:SymbolDetail = SymbolDetail()
                        detail.Name = name
                        detail.symbol = symbol.uppercaseString
                        
                        if let price = jsonItem["LastTradePriceOnly"].string{
                            detail.lastTradePrice = price
                        }else{
                            detail.lastTradePrice = "N/A"
                        }
                
                        if let change = jsonItem["Change"].string{
                            detail.dayChange = change
                        }else{
                            detail.dayChange = "N/A"
                        }
                
                        if let dh = jsonItem["DaysHigh"].string{
                            detail.daysHigh = dh
                        }else{
                            detail.daysHigh = "N/A"
                        }
                
                        if let dl = jsonItem["DaysLow"].string{
                            detail.daysLLow = dl
                        }else{
                            detail.daysLLow = "N/A"
                        }
                
                        if let adv = jsonItem["AverageDailyVolume"].string{
                            detail.averageDailyVolume = adv
                        }else{
                            detail.averageDailyVolume = "N/A"
                        }
                
                        if let yh = jsonItem["YearHigh"].string{
                            detail.yearHigh = yh
                        }else{
                            detail.yearHigh = "N/A"
                        }
                
                        if let yl = jsonItem["YearLow"].string{
                            detail.yearLow = yl
                        }else{
                            detail.yearLow = "N/A"
                        }
                
                        if let mc = jsonItem["MarketCapitalization"].string{
                            detail.marketCap = mc
                        }else{
                            detail.marketCap = "N/A"
                        }
                        
                        self.updateSymbol(detail)
                    }
                }
                c = c - 1
            }
        }
        
        if delegateType == "PortFolioTableViewController"{
            if let d = delegate as? PortFolioTableViewController{
                d.updateAllPortFolio(true)
            }
        }
        
    }
    
    func requestSymbols(symbols:String?){
        if let s = symbols{
            let urlString:URLStringConvertible = "https://query.yahooapis.com/v1/public/yql"
            let sql:String = "select * from yahoo.finance.quote where symbol in" + s
            let params:[String:AnyObject]? = ["q":sql,"format":"json","diagnostics":"true","env":"store://datatables.org/alltableswithkeys"]
 
            Alamofire.request(.GET, urlString, parameters: params).responseJSON{response in
                switch response.result{
                case .Success(let _):
                    if let value = response.result.value{
                        let json = JSON(value)
                        //print(json)
                        self.dealSymbolsJson(json)
                    }
                    
                case .Failure(let error):
                    print("\(error)")
                }
            }
            
        }else{
            if delegateType == "PortFolioTableViewController"{
                if let d = delegate as? PortFolioTableViewController{
                    d.updateAllPortFolio(false)
                }
            }
        }
    }
    
    func refreshPortfolio(d:AnyObject,type:String){
        delegate = d
        delegateType = type
        
        var symbols:String = "("
        var n:Int = 0
        
        for item in symbolArray{
            if item.symbol == "EDITCELL"{
                continue
            }else{
                if let s = item.symbol{
                    symbols = symbols + "\"" + s + "\"" + ","
                    n = n + 1
                }
            }
        }
        
        if n > 0{ //make sure symbols not empty
            symbols = symbols.substringToIndex(symbols.endIndex.predecessor()) //remove last ","
            symbols = symbols + ")"
            print(symbols)
            requestSymbols(symbols)
        }else{
            requestSymbols(nil)
        }
    }
    
    
}
