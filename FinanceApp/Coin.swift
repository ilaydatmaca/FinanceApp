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
}

let coins : [Coin] = [
    Coin(label : "Bitcoin", image: UIImage(named: "bitcoin")!),
    Coin(label : "Avalanche", image: UIImage(named: "avalanche")!),
    Coin(label : "Ethereum", image: UIImage(named: "ethereum")!),
    Coin(label : "Tether", image: UIImage(named: "tether")!),
    Coin(label : "Coinbase", image: UIImage(named: "coinbase")!),
    Coin(label : "Shiba", image: UIImage(named: "shiba")!)
]
