//
//  Coin.swift
//  FinanceApp
//
//  Created by Şevval Atmaca on 21.06.2022.
//

import UIKit


struct Coin{
    let label : String
    let image : UIImage
    let shortening : String
    let price : String
}

let coins : [Coin] = [
    Coin(label : "Bitcoin", image: UIImage(named: "bitcoin")!, shortening : "BTC", price: "$456,322"),
    Coin(label : "Avalanche", image: UIImage(named: "avalanche")!, shortening : "AVAX", price: "$456,322"),
    Coin(label : "Ethereum", image: UIImage(named: "ethereum")!, shortening : "ETH", price: "$456,322"),
    Coin(label : "Tether", image: UIImage(named: "tether")!, shortening : "USDT", price: "$456,322"),
    Coin(label : "Coinbase", image: UIImage(named: "coinbase")!, shortening : "COIN", price: "$456,322"),
    Coin(label : "Shiba", image: UIImage(named: "shiba")!, shortening : "SHIB", price: "$456,322")
]
