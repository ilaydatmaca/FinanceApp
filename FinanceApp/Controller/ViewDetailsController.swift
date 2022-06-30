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
    
    
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinShortening: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    
    
    @IBOutlet weak var marketCap: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var rank: UILabel!
    
    static var currentCoin : Coin!
    
    @IBOutlet weak var ranktitle: UILabel!
    @IBOutlet weak var volumetitle: UILabel!
    @IBOutlet weak var marketCaptitle: UILabel!
    @IBOutlet weak var marketDatatitle: UILabel!
    @IBOutlet weak var btcPrice: UILabel!
    
    @IBOutlet weak var perDaily: UILabel!
    @IBOutlet weak var perWeekly: UILabel!
    
    @IBOutlet weak var chartview: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chartview.backgroundColor = .white
        chartview.rightAxis.enabled = false
        
        let yAxis = chartview.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .black
        yAxis.labelPosition = .insideChart
        chartview.xAxis.labelPosition = .bottom
        chartview.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartview.xAxis.setLabelCount(6, force: false)
        chartview.xAxis.labelTextColor = .black
        chartview.xAxis.axisLineColor = .black
        
        chartview.xAxis.gridColor = .clear
        chartview.leftAxis.gridColor = .clear
        chartview.rightAxis.gridColor = .clear

        chartview.animate(xAxisDuration: 2.5)
        
        
        DispatchQueue.main.async {
            self.setData()
        }
        setUpDetail()
    }
    
    
    func setData()
    {
        
        var lineChartEntry = [ChartDataEntry]()
        let urlStr = "https://api.coinstats.app/public/v1/charts?period=1w&coinId=" + ViewDetailsController.currentCoin.name.lowercased()
        
        ViewController.viewObj.fetchAny(urlString: urlStr, ChartData.self) { [weak self] coinsArr in
            
            for i in 0..<coinsArr.chart.count{
                
                let entrySet = ChartDataEntry(x: Double(i), y: coinsArr.chart[i][1])
                lineChartEntry.append(entrySet)
            }
            
            let set1 = LineChartDataSet(entries: lineChartEntry, label: "Prices")
            
            set1.mode = .cubicBezier
            set1.drawCirclesEnabled = false
            set1.lineWidth = 3
            DispatchQueue.main.async {
            set1.setColor(self!.perWeekly.textColor)
            set1.fillColor = (self?.perWeekly.textColor)!
            }
            
            
            set1.fillAlpha = 0.8
            set1.drawFilledEnabled = true
            
            set1.drawHorizontalHighlightIndicatorEnabled = false
            set1.highlightColor = .systemGray
            let data = LineChartData(dataSet: set1)
            data.setDrawValues(false)
            self!.chartview.data = data
            let colorX = self!.perWeekly.textColor
            let gradColors = [UIColor.white.cgColor, colorX!.cgColor]
            let colorLocations:[CGFloat] = [0.0, 1.0]
            if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradColors as CFArray, locations: colorLocations) {
                set1.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
            }
            
        }
    }

    
    
    func setUpDetail(){
        coinIcon.image = ViewDetailsController.currentCoin.image
        coinName.text = ViewDetailsController.currentCoin.name
        coinShortening.text = ViewDetailsController.currentCoin.shortening
        coinPrice.text = ViewDetailsController.currentCoin.price
        
        marketCap.text = "$" + String(format: "%.2f", ViewDetailsController.currentCoin.marketCap / CGFloat.billion ) + "B"
        
        volume.text = "$" + String(format: "%.2f", ViewDetailsController.currentCoin.volume / CGFloat.billion ) + "B"
        rank.text = "#" + String(ViewDetailsController.currentCoin.rank)
        btcPrice.text = String(format: "%.2f", ViewDetailsController.currentCoin.btcPrice) + " BTC"
        
        
        btcPrice.textColor = UIColor(red: 0.3451, green: 0.4039, blue: 0.3333, alpha: 1.0)
        marketDatatitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        
        marketCaptitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        volumetitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        ranktitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        
        perDaily.text = String(ViewDetailsController.currentCoin.priceChange1D)
        perWeekly.text = String(ViewDetailsController.currentCoin.priceChange1W)
        
        if ViewDetailsController.currentCoin.priceChange1D < 0{
            perDaily.textColor =  UIColor.red
        }
        else{
            perDaily.textColor =  UIColor.green

        }
        if ViewDetailsController.currentCoin.priceChange1W < 0{
            perWeekly.textColor = UIColor.red
        }else{
            perWeekly.textColor = UIColor.green

        }
    }
    
}
