//
//  ViewController.swift
//  WasteManagement
//
//  Created by Rencheeraj Mohan on 02/06/23.
//

import UIKit
import Kingfisher
class ViewController: UIViewController {

    @IBOutlet weak var featuredProductsCollectionView: UICollectionView!
    var valueResponse : [FeaturedProduct]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APIManager.shared.getJsonResult() { result in
            switch result{
            case .success(let json):
                print(json)
                self.valueResponse = json.data.featuredProducts
                self.setResponseData(result: self.valueResponse!)
            case .failure(let error):
                print(error)
            }
        }
    }
    func setResponseData(result : [FeaturedProduct]){
        DispatchQueue.main.async {
            self.featuredProductsCollectionView.delegate = self
            self.featuredProductsCollectionView.dataSource = self
            self.featuredProductsCollectionView.register(UINib(nibName: "FeaturedProductCollectioViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedProductCollectioViewCell")
            self.featuredProductsCollectionView.reloadData()
        }
    }

}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return valueResponse?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedProductCollectioViewCell", for: indexPath) as? FeaturedProductCollectioViewCell else {
            return UICollectionViewCell()
        }
        cell.featuredProductTitle.text = valueResponse![indexPath.row].name
        cell.featuredProductDataNames.text = valueResponse![indexPath.row].products[0].product_name
        let url = URL(string: valueResponse?[indexPath.row].image ?? "")
        cell.featuredProductImage.kf.setImage(with: url)
        setSandL(cell: cell)
//        cell.contentView.layer.cornerRadius = 2
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        cell.layer.shadowRadius = 2.0
//        cell.layer.shadowOpacity = 0.3
//        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    func setSandL(cell : UICollectionViewCell){
        cell.contentView.layer.cornerRadius = 2
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width/3.3, height: UIScreen.main.bounds.width/3.3)
    }
}

