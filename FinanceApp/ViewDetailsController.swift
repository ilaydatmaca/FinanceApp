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
    
    static var tapCoin2 : Coin!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDetail()
    }
    
    func setUpDetail(){
        coinIcon.image = ViewDetailsController.tapCoin2.image
        coinName.text = ViewDetailsController.tapCoin2.label
        coinShortening.text = ViewDetailsController.tapCoin2.shortening
        coinPrice.text = ViewDetailsController.tapCoin2.price
        
        
    }

}
