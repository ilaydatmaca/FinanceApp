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
    @IBOutlet weak var coinPercent: UILabel!
    
    
    func setup(with coin : Coin){
        coinName.text = coin.name
        coinImage.image = coin.image
        coinShortening.text = coin.shortening
        coinPrice.text = "$" + String(format: "%.2f", coin.price)
        coinName.font = UIFont(name:"Montserrat-SemiBold", size: 17.0)
        coinShortening.font = UIFont(name:"Montserrat-Regular", size: 16.0)
        coinPrice.font = UIFont(name:"Montserrat-SemiBold", size: 16.0)

            
        }

}



