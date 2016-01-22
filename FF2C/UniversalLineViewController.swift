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
    var time:DataTimeSteps?
    var source:DataSourceType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        
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
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?,des:String?,name:String?,symbol:String?,level:String?,url:String?,time:DataTimeSteps?,source:DataSourceType?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.name = name
        self.symbol = symbol
        self.level = level
        self.des = des
        
        self.url = url
        self.time = time
        self.source = source
        
        Quote.sharedInstance.universalRequest(name,url: url, time: time, source: source,o: self,type:.UniversalLineCharView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func fiveDayButtonClicked(sender: AnyObject) {
        self.indicator.startAnimating()
        Quote.sharedInstance.universalRequest(self.name, url: self.url, time: .FiveDay, source: self.source, o: self, type:.UniversalLineCharView)
    }
    
    @IBAction func oneMonthButtonClicked(sender: AnyObject) {
        self.indicator.startAnimating()
        Quote.sharedInstance.universalRequest(self.name, url: self.url, time: .OneMonth, source: self.source, o: self, type:.UniversalLineCharView)
    }
    
    @IBAction func threeMonthButtonClicked(sender: AnyObject) {
        self.indicator.startAnimating()
        Quote.sharedInstance.universalRequest(self.name, url: self.url, time: .ThreeMonth, source: self.source, o: self, type:.UniversalLineCharView)        
    }
    
    @IBAction func oneYearButtonClicked(sender: AnyObject) {
        self.indicator.startAnimating()
        Quote.sharedInstance.universalRequest(self.name, url: self.url, time: .OneYear, source: self.source, o: self, type:.UniversalLineCharView)
    }
    
    @IBAction func fiveYearButtonClicked(sender: AnyObject) {
        self.indicator.startAnimating()
        Quote.sharedInstance.universalRequest(self.name, url: self.url, time: .FiveYear, source: self.source, o: self, type:.UniversalLineCharView)
    }
    
    @IBAction func tenYearButtonClicked(sender: AnyObject) {
        self.indicator.startAnimating()
        Quote.sharedInstance.universalRequest(self.name, url: self.url, time: .TenYear, source: self.source, o: self, type:.UniversalLineCharView)
    }
    
    func updateLineChartData(data : LineChartData?){
        self.indicator.stopAnimating()
        
        if let d = data{
            usualLineChartView.data = d
            usualLineChartView.animate(xAxisDuration: 1.0, easingOption: ChartEasingOption.Linear)
        }else{
            usualLineChartView.noDataText = "由于网络问题，无法得到有效的数据源"
        }

    }
    
    
}