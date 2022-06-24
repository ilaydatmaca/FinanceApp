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
    
    static var tapCoin : Coin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDetail()
    }
    
    func setUpDetail(){
        coinIcon.image = ViewDetailsController.tapCoin.image
        coinName.text = ViewDetailsController.tapCoin.label
        coinShortening.text = ViewDetailsController.tapCoin.shortening
        coinPrice.text = ViewDetailsController.tapCoin.price
        
        
    }

}
