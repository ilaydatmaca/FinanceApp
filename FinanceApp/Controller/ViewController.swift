//
//  ViewController.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 17.06.2022.
//

import UIKit
import Charts
final class ViewController: UIViewController, UISearchResultsUpdating, UITextViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var coinsList: [Coin] = [] //all coins in the api
    var filteredData : [Coin] = []//filtered coins if there is a seach
    var graphData : [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchAny(urlString: "https://api.coinstats.app/public/v1/coins", CoinsRequest.self) { [weak self] coinsArr in
            
            for i in coinsArr.coins{
                let roundedPrice = "$" + String(round(100 * i.price) / 100)
                
                self!.coinsList.append(Coin(name: i.name, image: UIImage(), shortening: i.symbol, price: roundedPrice, buttonID: i.rank, imageURLString: i.icon, btcPrice: i.priceBtc, marketCap: i.marketCap, volume: i.volume ?? 0.0 , rank: i.rank))
                
            }
            
            DispatchQueue.main.async {
                self?.filteredData = self?.coinsList ?? []
                self?.collectionView.reloadData()
            }
            
        }
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        searchBar.delegate = self
    }
    
    
    @IBAction func didTap(_ sender: UIButton){ //if you press a coin then it will open their details screen
        if let i = filteredData.firstIndex(where: { $0.buttonID == sender.tag }) { //find the id of pressed coin
            ViewDetailsController.currentCoin = filteredData[i]//then arrange details screen for this coin
        }
        performSegue(withIdentifier: "detailView", sender: self)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != nil else{
            return
        }
    }
    
    func fetchAny<T : Decodable>(urlString: String,_ typeClass: T.Type, completionHandler: @escaping (T) -> Void) {
        
        guard let url = URL(string: urlString) else { return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                return
            }
            
            if let data = data,
               let coinResult = try? JSONDecoder().decode(T.self, from: data) {
                completionHandler(coinResult)
            }
            
        })

        task.resume()
    }
    
}

// MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//this function is calling for cells in the screen
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        
        let urlString = filteredData[indexPath.row].imageURLString //take url string for each cell in the screen
        
        ImageLoader.sharedInstance.imageForUrl(urlString: urlString, completionHandler: { [self] (image, url) in
            if(filteredData.count == 0){//if the result is empty then return back
                return
            }
            
            if image != nil {//else shows images
                self.filteredData[indexPath.row].image = image!
                self.coinsList[indexPath.row].image = image!
                cell.setup(with: filteredData[indexPath.row])
            }
        })
        
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
