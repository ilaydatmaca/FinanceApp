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
    
    var coin : Coin!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDetail()
    }
    
    func setUpDetail(){
        /*coinIcon.image = coin.image
        coinName.text = coin.label
        coinShortening.text = coin.shortening
        coinPrice.text = coin.price*/
    }

}
