//
//  QuoteLineViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/29.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit
import Charts

class QuoteLineViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var buttonToday: UIButton!
    @IBOutlet weak var button5D: UIButton!
    @IBOutlet weak var button1M: UIButton!
    @IBOutlet weak var button3M: UIButton!
    @IBOutlet weak var button1Y: UIButton!
    @IBOutlet weak var button2Y: UIButton!
    @IBOutlet weak var button5Y: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.backgroundColor = UIColor.orangeColor()
    }
}
