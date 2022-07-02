//
//  ViewController.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 17.06.2022.
//

import UIKit
import Charts

class ViewController: UIViewController, UISearchResultsUpdating, UITextViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var coinsList: [Coin] = [] //all coins in the api
    var filteredData : [Coin] = []//filtered coins if there is a seach
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLLoader.sharedInstance.anyForUrl(typeStr: "str", urlString: "https://api.coinstats.app/public/v1/coins",
                                           typeClass: CoinsRequest.self) {[self] (image, url, result) in
            
            for i in result!.coins{
                
                self.coinsList.append(Coin(name: i.name, image: UIImage(), shortening: i.symbol, price: i.price, imageURLString: i.icon, btcPrice: i.priceBtc, marketCap: i.marketCap, volume: i.volume ?? 0.0 , rank: i.rank, priceChange1D: i.priceChange1D, priceChange1W: i.priceChange1W))
            }
            
            DispatchQueue.main.async {
                self.filteredData = self.coinsList
                self.collectionView.reloadData()
            }
            
        }
        
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        searchBar.delegate = self
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != nil else{
            return
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//this function is calling for cells in the screen
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        
        let urlString = filteredData[indexPath.row].imageURLString //take url string for each cell in the screen
        
        
        URLLoader.sharedInstance.anyForUrl(typeStr: "image", urlString: urlString, typeClass: CoinsRequest.self) {[self] (image, url, returnObj) in
            if(self.filteredData.count == 0){//if the result is empty then return back
                return
            }
            
            if image != nil {//else shows images
                self.filteredData[indexPath.row].image = image!
                self.coinsList[indexPath.row].image = image!
                cell.setup(with: filteredData[indexPath.row])
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {//filtered data count
        return filteredData.count
    }
    
    //for UI
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
    //each cell's size is half of screeen
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat.halfSizeOfScreen, height: CGFloat.halfSizeOfScreen)
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ViewDetailsController.currentCoin = filteredData[indexPath.item]
        performSegue(withIdentifier: "detailView", sender: self)
    }
}

// MARK: - UISearchBarDelegate
extension ViewController : UISearchBarDelegate{
    
    //when click the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == ""//if the search text is empty then shows all coins
        {
            filteredData = coinsList
        }
        for word in coinsList{ //else just shows according to search text
            if word.name.uppercased().contains(searchText.uppercased())
            {
                filteredData.append(word)
            }
        }
        self.collectionView.reloadData()//reload data
    }
}
