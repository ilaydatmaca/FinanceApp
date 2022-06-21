//
//  CoinCollectionViewCell.swift
//  FinanceApp
//
//  Created by Şevval Atmaca on 21.06.2022.
//

import UIKit

class CoinCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coinText: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    
    func setup(with coin : Coin){
        coinText.text = coin.label
        coinImage.image = coin.image
    }
}
