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
        static let SectionNum:Int = 1
        static let DefaultTotalCellNum:Int = 3
        static let RowHeight:CGFloat = 40.0
        static let LabelPercentageCornerRadius:CGFloat = 5
    }
}
