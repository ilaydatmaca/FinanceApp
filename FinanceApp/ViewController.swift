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
        //view.backgroundColor = .systemBlue
    }
}
class ViewController: UIViewController, UISearchResultsUpdating {
    
    
    let searchController = UISearchController(searchResultsController: ResultsVC())
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        //searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{
            return
        }
        //let vc = searchController.searchResultsController as? ResultsVC
        //vc.view.backgroundColor = .white

        print(text)
    }
    
 }

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
        print(UIScreen.main.bounds.width / 2)
        return CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
    }
}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(coins[indexPath.row].label)
    }
}

