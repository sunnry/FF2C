//
//  SymbolXmlParser.swift
//  FF2C
//
//  Created by sunny sun on 16/1/8.
//  Copyright © 2016年 sunny sun. All rights reserved.
//

import Foundation

class SymbolXmlParser: NSObject {
    
    override init() {
        super.init()
    }
    
    func dataFilePath()->String{
        
        let docPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory,NSSearchPathDomainMask.UserDomainMask, true)
        
        let docPath = docPaths[0]
        
        let ff2cDir = docPath + "/ff2c" + "/" + AppConfiguration.XmlParser.fullname
        
        return ff2cDir
    }
    
    
    func createResources()->Bool{
        
        let docPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory,NSSearchPathDomainMask.UserDomainMask, true)
        
        let docPath = docPaths[0]
        
        let ff2cDir = docPath + "/ff2c"
        
        let fileManager = NSFileManager.defaultManager()
        
        let isExist = fileManager.fileExistsAtPath(ff2cDir)
        
        if isExist == false{
            do{
               try fileManager.createDirectoryAtPath(ff2cDir, withIntermediateDirectories: true, attributes: nil)
                
               let filePath = ff2cDir + "/" + AppConfiguration.XmlParser.fullname
                
                let info = " "
                
                try info.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
            }catch{
                print("create \(ff2cDir) failed")
                return false
            }
        }else{
            return true
        }
        
        return true
    }
    
    
    func saveXmlResources(){
        
        let SYMBOLElement = GDataXMLNode.elementWithName("SYMBOLS")
        
        for item in Quote.sharedInstance.symbolArray{
            if item.symbol == "EDITCELL"{
                continue
            }
            let symbolsElement = GDataXMLNode.elementWithName("symbols", stringValue: item.symbol)
            
            let stockSymbolElement = GDataXMLNode.elementWithName("symbol", stringValue: item.symbol)
            symbolsElement.addChild(stockSymbolElement)
            
            let nameElement = GDataXMLNode.elementWithName("Name", stringValue: item.Name)
            symbolsElement.addChild(nameElement)
            
            let dayhighElement = GDataXMLNode.elementWithName("dayHigh", stringValue: item.daysHigh)
            symbolsElement.addChild(dayhighElement)
            
            let daylowElement = GDataXMLNode.elementWithName("dayLow", stringValue: item.daysLLow)
            symbolsElement.addChild(daylowElement)
            
            let yearHighElement = GDataXMLNode.elementWithName("yearHigh", stringValue: item.yearHigh)
            symbolsElement.addChild(yearHighElement)
            
            let yearLowElement = GDataXMLNode.elementWithName("yearLow", stringValue: item.yearLow)
            symbolsElement.addChild(yearLowElement)
            
            let dayChangeElement = GDataXMLNode.elementWithName("dayChange", stringValue: item.dayChange)
            symbolsElement.addChild(dayChangeElement)
            
            let averageDailyVolumeElement = GDataXMLNode.elementWithName("averageDailyVolume", stringValue: item.averageDailyVolume)
            symbolsElement.addChild(averageDailyVolumeElement)
            
            let lastTradePriceElement = GDataXMLNode.elementWithName("lastTradePrice", stringValue: item.lastTradePrice)
            symbolsElement.addChild(lastTradePriceElement)
            
            let marketCapElement = GDataXMLNode.elementWithName("marketCap", stringValue: item.marketCap)
            symbolsElement.addChild(marketCapElement)
            
            SYMBOLElement.addChild(symbolsElement)
            
        }
        
        let xmlDocument = GDataXMLDocument(rootElement: SYMBOLElement)
        
        let xmlData = xmlDocument.XMLData()
        
        //print(xmlData)
        
        let c = createResources()
        
        if c == true{
                let path = dataFilePath()
                do{
                    try xmlData.writeToFile(path, options: .AtomicWrite)
                }catch{
                    print("save SYMBOLS to xml failed")
                }
        }
    }
    
    
    func loadXmlResources()->[SymbolDetail]?{
        
        let c = createResources()
        
        var tempSymbolDetailArray = Array<SymbolDetail>()
        
        if c == true{
            let filepath = self.dataFilePath()
            let xmldata = NSMutableData(contentsOfFile: filepath)
            
            do{
                let doc = try GDataXMLDocument(data: xmldata)
                //print(doc.rootElement())
                
                let symbolArray:NSArray = doc.rootElement().elementsForName("symbols")
                
                if symbolArray.count > 0{
                    for item in symbolArray{
                        
                        var detail = SymbolDetail()

                        if let i = item as? GDataXMLElement{
                            
                            let symbol:NSArray = i.elementsForName("symbol")
                            if symbol.count > 0{
                                let s = symbol.objectAtIndex(0)
                                //print(s.stringValue)
                                detail.symbol = s.stringValue
                            }
                            
                            let name:NSArray = i.elementsForName("Name")
                            if name.count > 0{
                                let n = name.objectAtIndex(0)
                                detail.Name = n.stringValue
                            }
                            
                            let dayHigh:NSArray = i.elementsForName("dayHigh")
                            if dayHigh.count > 0{
                                let dh = dayHigh.objectAtIndex(0)
                                detail.daysHigh = dh.stringValue
                            }
                            
                            let dayLow:NSArray = i.elementsForName("dayLow")
                            if dayLow.count > 0{
                                let dl = dayLow.objectAtIndex(0)
                                detail.daysLLow = dl.stringValue
                            }
                            
                            let yearHigh:NSArray = i.elementsForName("yearHigh")
                            if yearHigh.count > 0{
                                let yh = yearHigh.objectAtIndex(0)
                                detail.yearHigh = yh.stringValue
                            }
                            
                            let yearLow:NSArray = i.elementsForName("yearLow")
                            if yearLow.count > 0{
                                let yl = yearLow.objectAtIndex(0)
                                detail.yearLow = yl.stringValue
                            }
                            
                            let dayChange:NSArray = i.elementsForName("dayChange")
                            if dayChange.count > 0{
                                let dc = dayChange.objectAtIndex(0)
                                detail.dayChange = dc.stringValue
                            }
                            
                            let averageDailyVolume:NSArray = i.elementsForName("averageDailyVolume")
                            if averageDailyVolume.count > 0{
                                let adv = averageDailyVolume.objectAtIndex(0)
                                detail.averageDailyVolume = adv.stringValue
                            }
                            
                            let lastTradePrice:NSArray = i.elementsForName("lastTradePrice")
                            if lastTradePrice.count > 0{
                                let ltp = lastTradePrice.objectAtIndex(0)
                                detail.lastTradePrice = ltp.stringValue
                            }
                            
                            let marketCap:NSArray = i.elementsForName("marketCap")
                            if marketCap.count > 0{
                                let mc = marketCap.objectAtIndex(0)
                                detail.marketCap = mc.stringValue
                            }
                            
                        }
                        tempSymbolDetailArray.append(detail)
                    
                    }
                }
                return tempSymbolDetailArray
                
            }catch{
                print("can not load local xml file")
                return nil
            }
        }
        return nil
    }
    
}