//
//  ApiData.swift
//  FinanceApp
//
//  Created by Şevval Atmaca on 23.06.2022.
//
import Foundation

struct CoinsRequest: Codable {
    let coins: [CoinData]
}

// MARK: - Coin
struct CoinData: Codable {
    let icon: String
    let name, symbol: String
    let rank: Int
    let price, priceBtc: Double
    let volume: Double?
    let marketCap: Double
    let priceChange1D, priceChange1W: Double

    
    enum CodingKeys: String, CodingKey {
        case icon, name, symbol, rank, price, priceBtc, volume, marketCap
        case priceChange1D = "priceChange1d"
        case priceChange1W = "priceChange1w"
    }
}

struct ChartData: Codable {
    let chart: [[Double]]
}
