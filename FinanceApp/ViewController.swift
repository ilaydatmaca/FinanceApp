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
    
    private var coins: [Coin] = []
    
    private var symbol: [Symbol]?


    
    /*func fetchDataFromApi(){
        
        guard let gitUrl = URL(string: "https://api.btcturk.com/api/v2/server/exchangeinfo") else { return}
        
        URLSession.shared.dataTask(with: gitUrl) { [self] (data, response, error) in
            
            guard let data = data else { return }
        
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(Welcome.self, from: data)
                let arrData = gitData.data.symbols
                
                /*for i in arrData{
                    coins.append(Coin(label: i.name, image: UIImage(named: "bitcoin")!, shortening: i.numerator, price: String(i.minimumLimitOrderPrice)) )
                }*/
                print("method " , coins.count)
                    
            } catch let error {
                print("Error: ", error)
            }
            /*if let result = String(data:data, encoding: .utf8){
                print(result)
            }*/
        }.resume()
        
    }*/

    func fetchCoins(completionHandler: @escaping ([Symbol]) -> Void) {
        
        guard let url = URL(string: "https://api.btcturk.com/api/v2/server/exchangeinfo") else { return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching coins: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            return
          }

          if let data = data,
            let coinResult = try? JSONDecoder().decode(Welcome.self, from: data) {
              completionHandler(coinResult.data.symbols ?? [])
          }
        })
        task.resume()
      }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()

        fetchCoins{ [weak self] symbols in
                self?.symbol = symbols
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                  }
        }
        print(symbol?.count)
        print(coins.count)
        /*symbol?.forEach{
            print($0)
            
            coins.append(Coin(label: $0.name, image: UIImage(named: "bitcoin")!, shortening: $0.numerator, price: String($0.minimumLimitOrderPrice)) )
        };"[Symbol]?"*/
        
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
    }
    
 }

// MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        
        cell.setup(with: coins[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
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
