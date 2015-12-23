//
//  Quote.swift
//  FF2C
//
//  Created by sunny sun on 15/12/21.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import Foundation

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
}


class Quote:qDelegate {

    var symbolArray:[SymbolDetail]!
    
    static let sharedInstance:Quote = {
       return Quote()
    }()
    
    init(){
        symbolArray = Array<SymbolDetail>()
    }
    
    //return true = exit, return false = not existed
    private func symbolExited(symbol:String)->Bool{
        
        for item in symbolArray{
            if item.symbol == symbol{
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
            for i in 0...symbolArray.count{
                if symbolArray[i].symbol == s{
                    symbolArray.removeAtIndex(i)
                }
            }
            
        }
    }
    
    func updateSymbol(name: String, s: SymbolDetail) {
        //symbolArray?.updateValue(s, forKey: name)
    }
    
}
