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
}

let coins : [Coin] = [
    Coin(label : "Bitcoin", image: UIImage(named: "bitcoin")!, shortening : "BTC"),
    Coin(label : "Avalanche", image: UIImage(named: "avalanche")!, shortening : "AVAX"),
    Coin(label : "Ethereum", image: UIImage(named: "ethereum")!, shortening : "ETH"),
    Coin(label : "Tether", image: UIImage(named: "tether")!, shortening : "USDT"),
    Coin(label : "Coinbase", image: UIImage(named: "coinbase")!, shortening : "COIN"),
    Coin(label : "Shiba", image: UIImage(named: "shiba")!, shortening : "SHIB")
]
