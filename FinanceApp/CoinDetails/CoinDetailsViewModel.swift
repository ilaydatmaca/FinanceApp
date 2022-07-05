//
//  CoinDetailsViewModel.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 5.07.2022.
//

import Foundation
import UIKit
import Charts

class CoinDetailsViewModel : CoinDetailsViewModelProtocol{

    var curButton : UIButton = UIButton()
    var curTime : Int = Times.graph1W.rawValue
    var lineChartEntry = [ChartDataEntry]()
    var perWeekColor : UIColor!

    
    
    
    func setData(charData : ChartData){
        for i in 0..<charData.chart.count{
            
            let entrySet = ChartDataEntry(x: Double(i), y: charData.chart[i][1])
            lineChartEntry.append(entrySet)
        }
        
    }
    var changeHandler: ((CoinDetailsViewModelChange) -> Void)?
    
    //MARK: - Emit
    
    private func emit(_ change: CoinDetailsViewModelChange) {
        changeHandler?(change)
    }
    
}


enum Times : Int{
    case graph1D = 0
    case graph1W = 1
    case graph1M = 2
    case graph3M = 3
    case graph6M = 4
    case graph1Y = 5
}
