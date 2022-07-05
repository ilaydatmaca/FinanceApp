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
    
    func setup(with coin : Coin, image : UIImage){
        coinName.text = coin.name
        coinImage.image = image
        percentCoin.text = coin.coinPriceChange1D
        if percentCoin.text!.starts(with: "-") {percentCoin.textColor =  UIColor.red}
        else {percentCoin.textColor =  UIColor.green}
        coinShortening.text = coin.symbol
        coinPrice.text = coin.price
    }
    
}



