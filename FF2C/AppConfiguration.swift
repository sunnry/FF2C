//
//  AppConfiguration.swift
//  FF2C
//
//  Created by sunny sun on 15/12/9.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import CoreGraphics




struct AppConfiguration {
    struct SettingTableViewConfig {
        static let SectionNum:Int = 1
        static let TotoalCellNum:Int = 5
        static let RowHeight:CGFloat = 64.0
    }
    
    struct PortFolioTableViewConfig{
        static let FirstRow = 0
        
        static let SectionNum:Int = 1
        static let DefaultTotalCellNum:Int = 4
        static let RowHeight:CGFloat = 40.0
        static let LabelPercentageCornerRadius:CGFloat = 5
        
        static let AddPortFolioRowHeight:CGFloat = 30
    }
    
    struct SearchSymbolTableViewConfig{
        static let SectionNum:Int = 1
        static let DefaultTotoalCellNum:Int = 15
        static let RowHeight:CGFloat = 25.0
    }
    
    struct QuoteDetailTableViewConfig{
        static let FirstRow:Int = 0
        static let FirstRowHeight:CGFloat = 20.0
        
        static let secondRow:Int = 1
        static let secondRowHeight:CGFloat = 20.0
        
        static let lineTableRow:Int = 2
        static let lineTableHeight:CGFloat = 200.0
        
        static let DayRangeRow:Int = 3
        static let DayRangeRowHeight:CGFloat = 18.0
        
        static let VolumeRow:Int = 4
        static let VolumeRowHeight:CGFloat = 18.0
        
        static let WeeksRow:Int = 5
        static let WeeksRowHeight:CGFloat = 18.0
        
        static let EPSRow:Int = 6
        static let EPSRowHeight:CGFloat = 18.0
        
        static let PERow:Int = 7
        static let PERowHeight:CGFloat = 18.0
        
        static let YieldRow:Int = 8
        static let YieldRowHeight:CGFloat = 18.0
        
        static let MarketCapRow:Int = 9
        static let MarketCapRowHeight:CGFloat = 18.0
        
        
        
        static let defaultRowHeight:CGFloat = 20.0
    }
}
