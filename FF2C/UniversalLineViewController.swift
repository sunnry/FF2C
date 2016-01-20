//
//  UniversalLineViewController.swift
//  FF2C
//
//  Created by sunny sun on 16/1/18.
//  Copyright © 2016年 sunny sun. All rights reserved.
//

import UIKit
import Charts

class UniversalLineViewController: UIViewController,ChartViewDelegate,qLineChartUpdate {
    
    @IBOutlet weak var usualLineChartView: LineChartView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var fiveDayButton: UIButton!
    
    @IBOutlet weak var oneMonthButton: UIButton!
    
    @IBOutlet weak var threeMonthButton: UIButton!
    
    @IBOutlet weak var oneYearButton: UIButton!
    
    @IBOutlet weak var fiveYearButton: UIButton!
    
    @IBOutlet weak var tenYearButton: UIButton!
    
    var des:String?
    var name:String?
    var level:String?
    var symbol:String?
    
    var url:String?
    var params:[String:AnyObject]?
    var source:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let description = self.des{
            descriptionLabel.text = description
        }
        
        if let n = self.name{
            nameLabel.text = n
        }
        
        if let l = self.level{
            levelLabel.text = l
        }
        
        
        
        usualLineChartView.delegate = self
        //lineChartView.backgroundColor = UIColor.orangeColor()
        
        usualLineChartView.noDataText = "请刷新"
        usualLineChartView.drawBordersEnabled = false
        usualLineChartView.scaleXEnabled = false
        usualLineChartView.scaleYEnabled = false
        usualLineChartView.dragEnabled = false
        usualLineChartView.drawGridBackgroundEnabled = false
        usualLineChartView.descriptionText = ""
        
        usualLineChartView.rightAxis.enabled = false
        
        usualLineChartView.leftAxis.drawLabelsEnabled = true
        usualLineChartView.leftAxis.gridColor = UIColor.lightGrayColor()
        usualLineChartView.leftAxis.gridLineDashLengths = [2.0]
        usualLineChartView.leftAxis.gridLineWidth = 0.1
        usualLineChartView.leftAxis.labelFont = UIFont.systemFontOfSize(5.0)
        usualLineChartView.leftAxis.labelTextColor = UIColor.lightGrayColor()
        usualLineChartView.leftAxis.drawAxisLineEnabled = false
        usualLineChartView.leftAxis.maxWidth = 18.0
        usualLineChartView.leftAxis.startAtZeroEnabled = false
        
        usualLineChartView.xAxis.labelTextColor = UIColor.lightGrayColor()
        usualLineChartView.xAxis.labelFont = UIFont.systemFontOfSize(5.0)
        usualLineChartView.xAxis.gridLineWidth = 0.1
        usualLineChartView.xAxis.gridLineDashLengths = [4.0]
        usualLineChartView.xAxis.drawAxisLineEnabled = false
        usualLineChartView.xAxis.labelPosition = .Bottom
        
        
        //legend is used to control AAPL label display and chart animation direction
        usualLineChartView.legend.form = .Line
        usualLineChartView.legend.font = UIFont.systemFontOfSize(7.0)
        usualLineChartView.legend.position = .BelowChartLeft
        
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?,des:String?,name:String?,symbol:String?,level:String?,url:String?,params:[String:AnyObject]?,source:String?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.name = name
        self.symbol = symbol
        self.level = level
        self.des = des
        
        self.url = url
        self.params = params
        self.source = source
        
        Quote.sharedInstance.universalRequest(url, params: params, source: source,o: self,type: "UniversalLineCharView")
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func fiveDayButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func oneMonthButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func threeMonthButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func oneYearButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func fiveYearButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func tenYearButtonClicked(sender: AnyObject) {
    }
    
    func updateLineChartData(data : LineChartData?){
        if let d = data{
            usualLineChartView.data = d
            usualLineChartView.animate(xAxisDuration: 1.0, easingOption: ChartEasingOption.Linear)
        }else{
            usualLineChartView.noDataText = "由于网络问题，无法得到有效的数据源"
        }

    }
    
    
}