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

class QuoteLineViewController: UIViewController,ChartViewDelegate {
    
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
            requestChart(tempSymbol)
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
        
        lineChartView.rightAxis.enabled = false
        
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.leftAxis.gridColor = UIColor.lightGrayColor()
        lineChartView.leftAxis.gridLineDashLengths = [2.0]
        lineChartView.leftAxis.gridLineWidth = 0.1
        lineChartView.leftAxis.labelFont = UIFont.systemFontOfSize(8.0)
        lineChartView.leftAxis.labelTextColor = UIColor.lightGrayColor()
        lineChartView.leftAxis.drawAxisLineEnabled = false
        
        
        lineChartView.xAxis.labelTextColor = UIColor.lightGrayColor()
        lineChartView.xAxis.labelFont = UIFont.systemFontOfSize(8.0)
        lineChartView.xAxis.gridLineWidth = 0.1
        lineChartView.xAxis.gridLineDashLengths = [4.0]
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.labelPosition = .Bottom
        
        
        lineChartView.legend.form = .Line
        //lineChartView.legend.position = .
        
        
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
        yVals?.append(ChartDataEntry(value: 2.0, xIndex: 2))
        yVals?.append(ChartDataEntry(value: 20.2, xIndex: 3))
        yVals?.append(ChartDataEntry(value: 12.2, xIndex: 4))
        yVals?.append(ChartDataEntry(value: -2.0, xIndex: 5))
        yVals?.append(ChartDataEntry(value: -9.0, xIndex: 8))
        
        
        let set1:LineChartDataSet = LineChartDataSet(yVals: yVals)
        set1.drawCircleHoleEnabled = false
        set1.drawCirclesEnabled = false
        
        
    
        var data:LineChartData = LineChartData(xVals: xVars, dataSet: set1)
        data.setDrawValues(true)
        
        //var data:LineChartData = LineChartData()
        //data.addDataSet(set1)
        
        
        lineChartView.data = data
        
        lineChartView.animate(xAxisDuration: 2.0, easingOption: ChartEasingOption.Linear)
    }
    
    
    func requestChart(symbol:String){
        
        let urlString:URLStringConvertible = "https://query.yahooapis.com/v1/public/yql"
        let sql:String = "select * from yahoo.finance.historicaldata where symbol = \"" + symbol + "\" and startDate=\"2015-11-18\" and endDate=\"2015-12-18\""
        
        let params:[String:AnyObject]? = ["q":sql,"format":"json","diagnostics":"true","env":"store://datatables.org/alltableswithkeys"]
        
        Alamofire.request(.GET, urlString, parameters: params).responseJSON{response in
            switch response.result{
            case .Success(let _):
                if let value = response.result.value{
                    let json = JSON(value)
                    print("\(json)")
                    
                }
                
            case .Failure(let error):
                print("\(error)")
            }
        }
        
        
    }
}
