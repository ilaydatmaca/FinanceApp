//
//  ViewController.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 17.06.2022.
//

import UIKit

final class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITextViewDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var coinsList: [Coin] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCoins{ [weak self] coins in
                self?.coinsList = coins
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                  }
        }
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    @IBAction func didTap(_ sender: UIButton){
        if let i = coinsList.firstIndex(where: { $0.buttonID == sender.tag }) {
            ViewDetailsController.currentCoin = coinsList[i]
        }
        performSegue(withIdentifier: "detailView", sender: self)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != nil else{
            return
        }
    }
    
    
    func fetchCoins(completionHandler: @escaping ([Coin]) -> Void) {
        
        guard let url = URL(string: "https://api.coinstats.app/public/v1/coins") else { return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
            return
          }

          if let data = data,
            let coinResult = try? JSONDecoder().decode(CoinsRequest.self, from: data) {
              var myCoins : [Coin] = []
              
              for i in coinResult.coins{
                  
                  let roundedPrice = "$" + String(round(100 * i.price) / 100)
                  
                  
                  myCoins.append(Coin(name: i.name, image: UIImage(), shortening: i.symbol, price: roundedPrice, buttonID: i.rank, imageURLString: i.icon, btcPrice: i.priceBtc, marketCap: i.marketCap, volume: i.volume ?? 0.0 , rank: i.rank))
              }
              
              completionHandler(myCoins)
          }
        })
        task.resume()
      }
 }

// MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
       
        let urlString = coinsList[indexPath.row].imageURLString

        ImageLoader.sharedInstance.imageForUrl(urlString: urlString, completionHandler: { [self] (image, url) in
            if image != nil {
                self.coinsList[indexPath.row].image = image!
                cell.setup(with: coinsList[indexPath.row])
            }
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coinsList.count
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat.halfSizeOfScreen, height: CGFloat.halfSizeOfScreen)
    }
}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(coinsList[indexPath.row].name)
    }
}

