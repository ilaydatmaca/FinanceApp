//
//  CoinCollectionViewCell.swift
//  FinanceApp
//
//  Created by Şevval Atmaca on 21.06.2022.
//

import UIKit

//for the first screen
class CoinCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var coinName: UILabel!
    @IBOutlet weak private var coinImage: UIImageView!
    
    @IBOutlet weak private var coinShortening: UILabel!
    @IBOutlet weak private var coinPrice: UILabel!
    
    @IBOutlet weak private var percentCoin: UILabel!
    
    func setup(with coin : Coin){
        coinName.text = coin.name
        coinImage.image = coin.image
        
        if (coin.priceChange1D >= 0){
            percentCoin.text = String(format: "+%.2f%%", coin.priceChange1D)
            percentCoin.textColor =  UIColor.green
            
        }else{
            percentCoin.text = String(format: "%.2f%%", coin.priceChange1D)
            percentCoin.textColor = UIColor.red
        }
        coinShortening.text = coin.shortening
        coinPrice.text = "$" + String(format: "%.2f", coin.price)
    }
    
}



