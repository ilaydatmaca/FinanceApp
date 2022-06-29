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
    
    
    
    lazy var lineChartView : LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .white
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .black
        yAxis.labelPosition = .insideChart
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .systemBlue
        
        chartView.animate(xAxisDuration: 2.5)
        
        return chartView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to : view)
        lineChartView.heightToWidth(of: view)
        
        setData()
        setUpDetail()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    }
    
    func setData()
    {
        
        var lineChartEntry = [ChartDataEntry]()
        ViewController.viewObj.fetchAny(urlString: "https://api.coinstats.app/public/v1/charts?period=1m&coinId=ethereum", ChartData.self) { [weak self] coinsArr in
            
            for i in 0..<coinsArr.chart.count{
                
                let entrySet = ChartDataEntry(x: Double(i), y: coinsArr.chart[i][1])
                lineChartEntry.append(entrySet)
                print(lineChartEntry)
            }
            
            let set1 = LineChartDataSet(entries: lineChartEntry, label: "Subscribers")
            
            set1.mode = .cubicBezier
            set1.drawCirclesEnabled = false
            set1.lineWidth = 3
            set1.setColor(.white)
            //set1.fill = Fill(UIColor : .white)
            set1.fillAlpha = 0.8
            set1.drawFilledEnabled = true
            
            
            set1.drawHorizontalHighlightIndicatorEnabled = false
            set1.highlightColor = .systemRed
            let data = LineChartData(dataSet: set1)
            data.setDrawValues(false)
            
            
            self!.lineChartView.data = data
            
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
    }
    
}
