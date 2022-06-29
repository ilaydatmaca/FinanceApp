//
//  ViewDetailsController.swift
//  FinanceApp
//
//  Created by Şevval Atmaca on 23.06.2022.
//

import UIKit

//for the details screen
class ViewDetailsController: UIViewController {

    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinShortening: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    

    @IBOutlet weak var marketCap: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var rank: UILabel!
    
    static var currentCoin : Coin!
    
    @IBOutlet weak var ranktitle: UILabel!
    @IBOutlet weak var volumetitle: UILabel!
    @IBOutlet weak var marketCaptitle: UILabel!
    @IBOutlet weak var marketDatatitle: UILabel!
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
        
        marketCap.text = "$" + String(format: "%.2f", ViewDetailsController.currentCoin.marketCap / CGFloat.billion ) + "B"
    
        volume.text = "$" + String(format: "%.2f", ViewDetailsController.currentCoin.volume / CGFloat.billion ) + "B"
        rank.text = "#" + String(ViewDetailsController.currentCoin.rank)
        btcPrice.text = String(format: "%.2f", ViewDetailsController.currentCoin.btcPrice) + " BTC"
    

        btcPrice.textColor = UIColor(red: 0.3451, green: 0.4039, blue: 0.3333, alpha: 1.0)
        marketDatatitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        
        marketCaptitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        volumetitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
        ranktitle.textColor = UIColor(red: 0.4471, green: 0.4471, blue: 0.4471, alpha: 1.0)
    }

}
