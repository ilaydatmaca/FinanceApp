//
//  ViewController.swift
//  FinanceApp
//
//  Created by İlayda Atmaca on 17.06.2022.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate,
                      UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let coins: [String]  = ["Bitcoin" ,"Avalanche", "Ethereum", "Tether", "Coinbase", "Shiba"]
    
    let coinImages: [UIImage] = [
     UIImage(named: "bitcoin")!,
     UIImage(named: "avalanche")!,
     UIImage(named: "ethereum")!,
     UIImage(named: "tether")!,
     UIImage(named: "coinbase")!,
     UIImage(named: "shiba")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.coinLabel.text = coins[indexPath.item]
        
        cell.coinImageView.image = coinImages[indexPath.item]
        return cell
        
        /*var cell = UICollectionViewCell()
        if let coinCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell{
            coinCell.configure(with: coins[indexPath.row])
            
            cell = coinCell
        }
        
        return cell*/
    }


}

