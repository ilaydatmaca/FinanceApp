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
    static var currentImage : UIImage!
    
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
    @IBOutlet weak var initialButton: UIButton!
    
    var detailsViewModel: CoinDetailsViewModelProtocol!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsViewModel = CoinDetailsViewModel()
        
        bindViewModel()
        
        detailsViewModel.curButton = initialButton
        setupDetails()
        detailsViewModel.perWeekColor = self.perWeekly.textColor
        setDataChart(period: "1w")


        
        
    }
    private func bindViewModel() {
        
        detailsViewModel.changeHandler = { [unowned self] change in
            switch change {
            case .onError(_):
                print("ERROR")
                break
            }
        }
    }
    
    @IBAction func allButtons(_ sender: UIButton) {
        if sender.tag == detailsViewModel.curTime{
            return
        }
        detailsViewModel.curButton.tintColor = .gray
        sender.tintColor = .black
        detailsViewModel.curButton = sender
        
        switch sender.tag{
        case 0:
            detailsViewModel.curTime = Times.graph1D.rawValue
            setDataChart(period: "24h")
        case 1:
            detailsViewModel.curTime = Times.graph1W.rawValue
            setDataChart(period: "1w")
        case 2:
            detailsViewModel.curTime = Times.graph1M.rawValue
            setDataChart(period: "1m")
        case 3:
            detailsViewModel.curTime = Times.graph3M.rawValue
            setDataChart(period: "3m")
        case 4:
            detailsViewModel.curTime = Times.graph6M.rawValue
            setDataChart(period: "6m")
        case 5:
            detailsViewModel.curTime = Times.graph1Y.rawValue
            setDataChart(period: "1y")
        default:
            break
        }
    }
    
    
    func setUIChart() {
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
        chartview.doubleTapToZoomEnabled = false
        chartview.pinchZoomEnabled = false
        chartview.scaleXEnabled = false
        chartview.scaleYEnabled = false
        
        chartview.animate(xAxisDuration: 2.5)
    }
    
    func setDataChart(period : String)
    {
        

        let urlStr = "https://api.coinstats.app/public/v1/charts?period=" + period + "&coinId=" + String(ViewDetailsController.currentCoin.name.lowercased().filter { !" \n\t\r".contains($0) })
        URLLoader.sharedInstance.anyForUrl(typeStr: "text", urlString: urlStr,
                                           typeClass: ChartData.self) {[self] (image, url, result) in
            
            if(result?.chart.count == 0){
                return
            }
            
            detailsViewModel.setData(charData: result!)
            DispatchQueue.main.async {
                self.setUIChart()

                let set1 = LineChartDataSet(entries: self.detailsViewModel.lineChartEntry, label: "Prices Weekly $")
                
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
    
    
    
    func setupDetails(){

        coinIcon.image = ViewDetailsController.currentImage
        coinName.text = ViewDetailsController.currentCoin.name
        coinShortening.text = ViewDetailsController.currentCoin.symbol
        coinPrice.text = ViewDetailsController.currentCoin.price
        marketCap.text = ViewDetailsController.currentCoin.coinMarketCap
        volume.text = ViewDetailsController.currentCoin.coinVolume
        rank.text = ViewDetailsController.currentCoin.coinRank
        btcPrice.text = ViewDetailsController.currentCoin.coinPriceBtc
        perDaily.text = ViewDetailsController.currentCoin.coinPriceChange1D
        perWeekly.text = ViewDetailsController.currentCoin.coinPriceChange1W
        if perDaily.text!.starts(with: "-") {perDaily.textColor =  UIColor.red}
        else {perDaily.textColor =  UIColor.green}
        if perWeekly.text!.starts(with: "-") {perWeekly.textColor = UIColor.red}
        else {perWeekly.textColor = UIColor.green}
    }
    
    
    
}

