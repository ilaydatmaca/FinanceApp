//
//  ViewDetailsController.swift
//  FinanceApp
//
//  Created by Şevval Atmaca on 23.06.2022.
//

import UIKit

class ViewDetailsController: UIViewController {

    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinShortening: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    
    @IBOutlet weak var marketCap: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var rank: UILabel!
    static var currentCoin : Coin!
    
    @IBOutlet weak var btcPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDetail()
    }
    
    func setUpDetail(){
        coinIcon.image = ViewDetailsController.currentCoin.image
        coinName.text = ViewDetailsController.currentCoin.name
        coinShortening.text = ViewDetailsController.currentCoin.shortening
        coinPrice.text = ViewDetailsController.currentCoin.price
        
        marketCap.text = String(format: "%.2f", ViewDetailsController.currentCoin.marketCap / CGFloat.billion )
    
        volume.text = String(format: "%.2f", ViewDetailsController.currentCoin.volume / CGFloat.billion )
        rank.text = String(ViewDetailsController.currentCoin.rank)
        btcPrice.text = String(ViewDetailsController.currentCoin.rank)
        
        
    }

}
