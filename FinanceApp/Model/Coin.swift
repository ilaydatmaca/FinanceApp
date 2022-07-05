//
//  Coin.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 5.07.2022.
//


import Foundation
import UIKit


struct Coin{

    let name: String
    let icon : String
    var image: UIImage
    let symbol: String
    let price: String
    let percent : String

    let coinRank: String
    let coinPriceBtc: String
    let coinVolume: String
    let coinMarketCap: String
    let coinPriceChange1D: String
    let coinPriceChange1W: String

    init(coin : CoinData){
        self.name = coin.name
        self.symbol = coin.symbol
        self.icon = coin.icon
        self.image = UIImage()
        self.price = "$" + String(format: "%.2f", coin.price)

        if (coin.priceChange1D >= 0){
            self.percent = String(format: "+%.2f%%", coin.priceChange1D)

        }else{
            self.percent = String(format: "%.2f%%", coin.priceChange1D)
        }

        self.coinRank = "#" + String(coin.rank)
        self.coinPriceBtc = String(format: "%.8f", coin.priceBtc) + " BTC"
        self.coinVolume = "$" + String(format: "%.2f", (coin.volume ?? 0) / CGFloat.billion ) + "B"
        self.coinMarketCap = "$" + String(format: "%.2f", coin.marketCap / CGFloat.billion ) + "B"

        self.coinPriceChange1D = coin.priceChange1D > 0 ? String(format: "+%.2f%%", coin.priceChange1D) : String(format: "%.2f%%", coin.priceChange1D)

        self.coinPriceChange1W = coin.priceChange1W > 0 ? String(format: "+%.2f%%", coin.priceChange1W) : String(format: "%.2f%%", coin.priceChange1W)




    }
}
