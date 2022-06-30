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
    
    @IBOutlet weak var ranktitle: UILabel!
    @IBOutlet weak var volumetitle: UILabel!
    @IBOutlet weak var marketCaptitle: UILabel!
    @IBOutlet weak var marketDatatitle: UILabel!
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
        case graphAll = 6
    }
    var curTime = Times.graph1W.rawValue
    var curButton = UIButton()
    
    
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
            setData(typePeriod: "24h")
        case 1:
            curTime = Times.graph1W.rawValue
            setData(typePeriod: "1w")
        case 2:
            curTime = Times.graph1M.rawValue
            setData(typePeriod: "1m")
        case 3:
            curTime = Times.graph3M.rawValue
            setData(typePeriod: "3m")
        case 4:
            curTime = Times.graph6M.rawValue
            setData(typePeriod: "6m")
        case 5:
            curTime = Times.graph1Y.rawValue
            setData(typePeriod: "1y")
        case 6:
            curTime = Times.graphAll.rawValue
            setData(typePeriod: "all")
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData(typePeriod: "1w")
        setUpDetail()
    }
    
    func setChart() {
        chartview.backgroundColor = .white
        chartview.rightAxis.enabled = false
        
        let yAxis = chartview.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .insideChart
        chartview.xAxis.labelPosition = .bottom
        chartview.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartview.xAxis.setLabelCount(6, force: false)
        chartview.xAxis.labelTextColor = .black
        chartview.xAxis.axisLineColor = .white
        
        chartview.setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 0)
        
        chartview.xAxis.gridColor = .clear
        chartview.leftAxis.gridColor = .clear
        chartview.rightAxis.gridColor = .clear
        
        chartview.animate(xAxisDuration: 2.5)
    }
    
    func setData(typePeriod : String)
    {
        var lineChartEntry = [ChartDataEntry]()
        let urlStr = "https://api.coinstats.app/public/v1/charts?period=" + typePeriod + "&coinId=" + String(ViewDetailsController.currentCoin.name.lowercased().filter { !" \n\t\r".contains($0) })
        URLLoader.sharedInstance.anyForUrl(typeStr: "str", urlString: urlStr,
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
        
        
        coinName.font = UIFont(name:"Montserrat-Medium", size: 18.0)
        coinPrice.font = UIFont(name:"Montserrat-Medium", size: 19.0)
        coinShortening.font = UIFont(name:"Montserrat-Medium", size: 18.0)
        btcPrice.font = UIFont(name:"Montserrat-Medium", size: 17.0)
        
        rank.font = UIFont(name: "Montserrat-Regular", size: 15)
        marketCap.font = UIFont(name: "Montserrat-Regular", size: 15)
        volume.font = UIFont(name: "Montserrat-Regular", size: 15)
        
        ranktitle.font = UIFont(name: "Montserrat-Medium", size: 15)
        marketCaptitle.font = UIFont(name: "Montserrat-Medium", size: 15)
        volumetitle.font = UIFont(name: "Montserrat-Medium", size: 15)
        marketDatatitle.font = UIFont(name: "Montserrat-Medium", size: 15)
        
        perWeekly.font = UIFont(name: "Montserrat-Medium", size: 17)
        perDaily.font = UIFont(name: "Montserrat-Medium", size: 17)
        
        
        btcPrice.textColor = UIColor(red: 0.3451, green: 0.4039, blue: 0.3333, alpha: 1.0)
        marketDatatitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        
        marketCaptitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        volumetitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        ranktitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        
        
        
        perDaily.text = ViewDetailsController.currentCoin.priceChange1D > 0 ? String(format: "+%.2f%%", ViewDetailsController.currentCoin.priceChange1D) : String(format: "%.2f%%", ViewDetailsController.currentCoin.priceChange1D)
        
        perWeekly.text = ViewDetailsController.currentCoin.priceChange1W > 0 ? String(format: "+%.2f%%", ViewDetailsController.currentCoin.priceChange1W) : String(format: "%.2f%%", ViewDetailsController.currentCoin.priceChange1W)
        
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

