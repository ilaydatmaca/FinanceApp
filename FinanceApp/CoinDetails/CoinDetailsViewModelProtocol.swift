//
//  CoinDetailsViewModelProtocol.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 5.07.2022.
//

import Foundation
import Charts
import UIKit
 
enum CoinDetailsViewModelChange {
    
    case onError(error:String)
}
 
protocol CoinDetailsViewModelProtocol {

    var changeHandler: ((CoinDetailsViewModelChange) -> Void)? { get set }

    var lineChartEntry : [ChartDataEntry] { get set }
    
    var curTime : Int {get set}
    var curButton : UIButton {get set}
    
    func setData(charData : ChartData)
    var perWeekColor : UIColor! {get set}

}
 
