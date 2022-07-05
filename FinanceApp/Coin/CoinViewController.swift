//
//  CoinViewController.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 17.06.2022.
//

import UIKit
import Charts

class CoinViewController: UIViewController, UISearchResultsUpdating, UITextViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - View Model
    var viewModel: CoinViewModelProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        viewModel = CoinsViewModel()
        bindViewModel()
        viewModel.getCoins()
    }
    
    //MARK: - Bind View Model
    
    private func bindViewModel() {
        
        viewModel.changeHandler = { [unowned self] change in
            switch change {
            case .onSuccessfullyCoinsLoaded:
                self.collectionView.reloadData()
                break
            case .onError(_):
                print("ERROR")
                break
            }
        }
    }
    
    
    func searching(searchText : String){
        viewModel.filteredCoins = []
        if searchText == ""
        {
            viewModel.filteredCoins = viewModel.coinsList
        }
        let searchTextFix = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        for word in viewModel.coinsList{
            if word.name.uppercased().contains(searchTextFix.uppercased())
            {
                viewModel.filteredCoins.append(word)
            }
        }
        collectionView.reloadData()

    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != nil else{
            return
        }
    }
}


// MARK: - UICollectionViewDataSource
extension CoinViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        
        let urlString = viewModel.filteredCoins[indexPath.row].icon
        
        URLLoader.sharedInstance.anyForUrl(typeStr: "image", urlString: urlString, typeClass: CoinsRequest.self) {[self] (image, url, returnObj) in
            if(viewModel.filteredCoins.count == 0){
                return
            }
            
            if image != nil {
                cell.setup(with: viewModel.filteredCoins[indexPath.row], image: image!)
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredCoins.count
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
extension CoinViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat.halfSizeOfScreen, height: CGFloat.halfSizeOfScreen)
    }
}

// MARK: - UICollectionViewDelegate
extension CoinViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        ViewDetailsController.currentCoin = viewModel.filteredCoins[indexPath.item]
        URLLoader.sharedInstance.anyForUrl(typeStr: "image", urlString: viewModel.filteredCoins[indexPath.item].icon, typeClass: CoinsRequest.self) { [self] (image, url, returnObj) in
            
            viewModel.setImage(image: image!)
            ViewDetailsController.currentImage = image
        }
        
        performSegue(withIdentifier: "detailView", sender: self)
    }
}

// MARK: - UISearchBarDelegate
extension CoinViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching(searchText: searchText)
    }
}
