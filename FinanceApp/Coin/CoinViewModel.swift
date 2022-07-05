//
//  CoinViewModel.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 5.07.2022.
//

import Foundation
import UIKit

class CoinsViewModel : CoinViewModelProtocol {
    
    var coinsList: [Coin] = []
    var filteredCoins : [Coin] = []
    var currentImage : UIImage!

    func setImage(image : UIImage){
        currentImage = image
    }

    func getCoins() {

        URLLoader.sharedInstance.anyForUrl(typeStr: "text", urlString: "https://api.coinstats.app/public/v1/coins",
                                           typeClass: CoinsRequest.self) {[self] (image, url, result) in
            self.coinsList = result?.coins.map({return Coin(coin: $0)}) ?? []

            DispatchQueue.main.async {
                self.filteredCoins = self.coinsList
                self.emit(.onSuccessfullyCoinsLoaded)
            }

        }
    }
    
    
    var changeHandler: ((CoinViewModelChange) -> Void)?
    
    //MARK: - Emit
    
    private func emit(_ change: CoinViewModelChange) {
        changeHandler?(change)
    }

}

