//
//  ViewDetailsController.swift
//  FinanceApp
//
//  Created by Şevval Atmaca on 23.06.2022.
//

import UIKit

import Charts
import TinyConstraints

//for the details screen
class ViewDetailsController: UIViewController, ChartViewDelegate {
    
    static var currentCoin : Coin!
    @IBOutlet weak var chartview: LineChartView!
    
    
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinShortening: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    
    @IBOutlet weak var marketCap: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var btcPrice: UILabel!
    
    @IBOutlet weak var perDaily: UILabel!
    @IBOutlet weak var perWeekly: UILabel!
    
    enum Times : Int{
        case graph1D = 0
        case graph1W = 1
        case graph1M = 2
        case graph3M = 3
        case graph6M = 4
        case graph1Y = 5
    }
    var curTime = Times.graph1W.rawValue
    var curButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData(period: "1w")
        setUpDetail()
    }
    
    
    @IBAction func allButtons(_ sender: UIButton) {
        if sender.tag == curTime{
            return
        }
        curButton.tintColor = .gray
        sender.tintColor = .black
        curButton = sender
        
        switch sender.tag{
        case 0:
            curTime = Times.graph1D.rawValue
            setData(period: "24h")
        case 1:
            curTime = Times.graph1W.rawValue
            setData(period: "1w")
        case 2:
            curTime = Times.graph1M.rawValue
            setData(period: "1m")
        case 3:
            curTime = Times.graph3M.rawValue
            setData(period: "3m")
        case 4:
            curTime = Times.graph6M.rawValue
            setData(period: "6m")
        case 5:
            curTime = Times.graph1Y.rawValue
            setData(period: "1y")
        default:
            break
        }
    }
    
    
    func setChart() {
        chartview.backgroundColor = .white
        chartview.xAxis.enabled = false
        
        let yAxis = chartview.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .insideChart
        
        
        chartview.setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 0)
        chartview.leftAxis.gridColor = .clear
        chartview.rightAxis.gridColor = .clear
        
        chartview.animate(xAxisDuration: 2.5)
    }
    
    func setData(period : String)
    {
        var lineChartEntry = [ChartDataEntry]()
        let urlStr = "https://api.coinstats.app/public/v1/charts?period=" + period + "&coinId=" + String(ViewDetailsController.currentCoin.name.lowercased().filter { !" \n\t\r".contains($0) })
        URLLoader.sharedInstance.anyForUrl(typeStr: "text", urlString: urlStr,
                                           typeClass: ChartData.self) {[self] (image, url, result) in
            
            if(result?.chart.count == 0){
                return
            }
            for i in 0..<result!.chart.count{
                
                let entrySet = ChartDataEntry(x: Double(i), y: result!.chart[i][1])
                lineChartEntry.append(entrySet)
            }
            
            DispatchQueue.main.async {
                self.setChart()
                let set1 = LineChartDataSet(entries: lineChartEntry, label: "Prices Weekly $")
                
                set1.mode = .cubicBezier
                set1.drawCirclesEnabled = false
                set1.lineWidth = 3
                set1.setColor(self.perWeekly.textColor)
                set1.fillColor = (self.perWeekly.textColor)!
                
                set1.fillAlpha = 0.8
                set1.drawFilledEnabled = true
                
                set1.drawHorizontalHighlightIndicatorEnabled = false
                set1.highlightColor = .systemGray
                let data = LineChartData(dataSet: set1)
                data.setDrawValues(false)
                self.chartview.data = data
                let colorX = self.perWeekly.textColor
                let gradColors = [UIColor.white.cgColor, colorX!.cgColor]
                let colorLocations:[CGFloat] = [0.0, 1.0]
                if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradColors as CFArray, locations: colorLocations) {
                    set1.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
                }
                
            }
        }
        
        
    }
    
    
    
    func setUpDetail(){
        coinIcon.image = ViewDetailsController.currentCoin.image
        coinName.text = ViewDetailsController.currentCoin.name
        coinShortening.text = ViewDetailsController.currentCoin.shortening
        coinPrice.text = "$" + String(format: "%.3f", ViewDetailsController.currentCoin.price)
        
        marketCap.text = "$" + String(format: "%.2f", ViewDetailsController.currentCoin.marketCap / CGFloat.billion ) + "B"
        
        volume.text = "$" + String(format: "%.2f", ViewDetailsController.currentCoin.volume / CGFloat.billion ) + "B"
        rank.text = "#" + String(ViewDetailsController.currentCoin.rank)
        btcPrice.text = String(format: "%.8f", ViewDetailsController.currentCoin.btcPrice) + " BTC"

        perDaily.text = ViewDetailsController.currentCoin.priceChange1D > 0 ? String(format: "+%.2f%%", ViewDetailsController.currentCoin.priceChange1D) : String(format: "%.2f%%", ViewDetailsController.currentCoin.priceChange1D)
        
        perWeekly.text = ViewDetailsController.currentCoin.priceChange1W > 0 ? String(format: "+%.2f%%", ViewDetailsController.currentCoin.priceChange1W) : String(format: "%.2f%%", ViewDetailsController.currentCoin.priceChange1W)
        
        if ViewDetailsController.currentCoin.priceChange1D < 0 {perDaily.textColor =  UIColor.red}
        else {perDaily.textColor =  UIColor.green}
        if ViewDetailsController.currentCoin.priceChange1W < 0 {perWeekly.textColor = UIColor.red}
        else {perWeekly.textColor = UIColor.green}
    }
    
    
    
}

