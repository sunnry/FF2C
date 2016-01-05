//
//  QuoteLineViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/29.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class QuoteLineViewController: UIViewController,ChartViewDelegate,qLineChartUpdate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var buttonToday: UIButton!
    @IBOutlet weak var button5D: UIButton!
    @IBOutlet weak var button1M: UIButton!
    @IBOutlet weak var button3M: UIButton!
    @IBOutlet weak var button1Y: UIButton!
    @IBOutlet weak var button2Y: UIButton!
    @IBOutlet weak var button5Y: UIButton!

    @IBAction func ButtonTodayAction(sender: AnyObject) {
    }

    @IBAction func button5DAction(sender: AnyObject) {
        print("5D pressed")
    }
    
    @IBAction func button1MAction(sender: AnyObject) {
    }
    
    @IBAction func button3MAction(sender: AnyObject) {
    }

    @IBAction func button1YAction(sender: AnyObject) {
    }
    
    @IBAction func button2YAction(sender: AnyObject) {
    }
    
    @IBAction func button5YAction(sender: AnyObject) {
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?,symbol:String?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if let tempSymbol = symbol{
            Quote.sharedInstance.requestOneMonthChart(tempSymbol, o: self, type: "LineChartView")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.delegate = self
        //lineChartView.backgroundColor = UIColor.orangeColor()

        lineChartView.noDataText = "无法得到有效的数据源"
        lineChartView.drawBordersEnabled = false
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.dragEnabled = false
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.descriptionText = ""
        
        lineChartView.rightAxis.enabled = false
        
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.leftAxis.gridColor = UIColor.lightGrayColor()
        lineChartView.leftAxis.gridLineDashLengths = [2.0]
        lineChartView.leftAxis.gridLineWidth = 0.1
        lineChartView.leftAxis.labelFont = UIFont.systemFontOfSize(5.0)
        lineChartView.leftAxis.labelTextColor = UIColor.lightGrayColor()
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.maxWidth = 15.0
        
        lineChartView.xAxis.labelTextColor = UIColor.lightGrayColor()
        lineChartView.xAxis.labelFont = UIFont.systemFontOfSize(5.0)
        lineChartView.xAxis.gridLineWidth = 0.1
        lineChartView.xAxis.gridLineDashLengths = [4.0]
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.labelPosition = .Bottom
        
        
        //legend is used to control AAPL label display and chart animation direction
        lineChartView.legend.form = .Line
        lineChartView.legend.font = UIFont.systemFontOfSize(7.0)
        lineChartView.legend.position = .BelowChartLeft
        
        
        var xVars:[NSObject]? = [NSObject]()
        xVars?.append("1")
        xVars?.append("2")
        xVars?.append("3")
        xVars?.append("4")
        xVars?.append("5")
        xVars?.append("6")
        xVars?.append("7")
        xVars?.append("8")
        xVars?.append("9")
        xVars?.append("10")
        
        var yVals:[ChartDataEntry]? = [ChartDataEntry]()
        yVals?.append(ChartDataEntry(value: 1.0, xIndex: 0))
        yVals?.append(ChartDataEntry(value: 2.0, xIndex: 1))
        yVals?.append(ChartDataEntry(value: 2.0, xIndex: 2))
        yVals?.append(ChartDataEntry(value: 20.2, xIndex: 3))
        yVals?.append(ChartDataEntry(value: 12.2, xIndex: 4))
        yVals?.append(ChartDataEntry(value: -2.0, xIndex: 5))
        yVals?.append(ChartDataEntry(value: -9.0, xIndex: 8))
        
        let set1:LineChartDataSet = LineChartDataSet(yVals: yVals)
        set1.label = "AAPL"

        set1.drawCircleHoleEnabled = false
        set1.drawCirclesEnabled = false
        
        let data:LineChartData = LineChartData(xVals: xVars, dataSet: set1)
        data.setValueFont(UIFont.systemFontOfSize(5.0))
    
        data.setDrawValues(true)
        
        
        lineChartView.data = data
        
        lineChartView.animate(xAxisDuration: 1.5, easingOption: ChartEasingOption.Linear)
    }
    
    func updateLineChartData(data: LineChartData?) {
        
        if let d = data{
            lineChartView.data = d
            lineChartView.animate(xAxisDuration: 1.0, easingOption: ChartEasingOption.Linear)
        }
    }

}
