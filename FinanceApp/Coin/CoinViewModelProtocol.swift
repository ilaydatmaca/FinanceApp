//
//  CoinViewModelProtocol.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 5.07.2022.
//

import Foundation
import UIKit
 
enum CoinViewModelChange {
    
    case onSuccessfullyCoinsLoaded
    case onError(error:String)
}
 
protocol CoinViewModelProtocol {
    
    var coinsList: [Coin] {get set}
    var filteredCoins : [Coin] {get set}
    
    var currentImage : UIImage! {get set}

    func getCoins()
    func setImage(image : UIImage)
    
    var changeHandler: ((CoinViewModelChange) -> Void)? { get set }
}
 
