//
//  ViewController.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 17.06.2022.
//

import UIKit

class ResultsVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
final class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITextViewDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet private weak var collectionView: UICollectionView!
    private let coins : [Coin] = [
        Coin(label : "Bitcoin", image: UIImage(named: "bitcoin")!, shortening : "BTC", price: "$456,322"),
        Coin(label : "Avalanche", image: UIImage(named: "avalanche")!, shortening : "AVAX", price: "$456,322"),
        Coin(label : "Ethereum", image: UIImage(named: "ethereum")!, shortening : "ETH", price: "$456,322"),
        Coin(label : "Tether", image: UIImage(named: "tether")!, shortening : "USDT", price: "$456,322"),
        Coin(label : "Coinbase", image: UIImage(named: "coinbase")!, shortening : "COIN", price: "$456,322"),
        Coin(label : "Shiba", image: UIImage(named: "shiba")!, shortening : "SHIB", price: "$456,322")
    ]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

    }
    
    
    @IBAction func didTap(_ sender: UIButton) {
        performSegue(withIdentifier: "detailView", sender: self)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{
            return
        }
        //let vc = searchController.searchResultsController as? ResultsVC
        //vc.view.backgroundColor = .white
    }

    
 }

// MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        cell.setup(with: coins[indexPath.row])
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat.halfSizeOfScreen, height: CGFloat.halfSizeOfScreen)
    }
}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(coins[indexPath.row].label)
    }
    
    
}
