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
    func delSymbol(name:String)
    func updateSymbol(name:String,s:SymbolDetail)
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
}


class Quote:qDelegate {

    var symbolArray:[String:SymbolDetail]?
    
    init(){
        symbolArray = [String:SymbolDetail]()
    }
    
    func addSymbol(s: SymbolDetail) {
        if let name = s.Name{
            symbolArray?[name] = s
        }
    }
    
    func delSymbol(name: String) {
        symbolArray?.removeValueForKey(name)
    }
    
    func updateSymbol(name: String, s: SymbolDetail) {
        symbolArray?.updateValue(s, forKey: name)
    }
    
}
