//
//  ViewController.swift
//  WasteManagement
//
//  Created by Rencheeraj Mohan on 02/06/23.
//

import UIKit
import Kingfisher
class ViewController: UIViewController {
    
    @IBOutlet weak var raisePickupButton: UIButton!
    @IBOutlet weak var featuredProductsCollectionView: UICollectionView!
    var valueResponse : [FeaturedProduct]?
    var arrSelectedIndex = [IndexPath]()
    var selectedArrayData = [FeaturedProduct]()
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
    
    
    @IBAction func raisePickUpAction(_ sender: Any) {
        if selectedArrayData.count == 0{
            alertShow(re: "Select Atleast one item")
        }else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
            nextViewController.modalPresentationStyle = .fullScreen
            nextViewController.displayData = selectedArrayData
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    func alertShow(re : String?){
            let alert = UIAlertController(title: "Select Item", message: "We cannot operate without selecting an option", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
    }
    
    func setResponseData(result : [FeaturedProduct]){
        DispatchQueue.main.async {
            self.featuredProductsCollectionView.delegate = self
            self.featuredProductsCollectionView.dataSource = self
            self.featuredProductsCollectionView.register(UINib(nibName: "FeaturedProductCollectioViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedProductCollectioViewCell")
            self.featuredProductsCollectionView.allowsMultipleSelection = true
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
        cell.tickImage.layer.cornerRadius = cell.tickImage.frame.width/2
        cell.featuredProductImage.kf.setImage(with: url)
        setSandL(cell: cell)
        
        if arrSelectedIndex.contains(indexPath){
            cell.tickImage.isHidden = false
            cell.tickImage.backgroundColor = UIColor(patternImage: .checkmark)
//            selectedArrayData.append(valueResponse![indexPath.row])
        }else{
            cell.tickImage.isHidden = true
        }
        return cell
    }
    func setSandL(cell : UICollectionViewCell){
        cell.contentView.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        cell.layer.shadowRadius = 1.5
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let strData : FeaturedProduct = valueResponse![indexPath.item]
        var indexForRemove : Int?
                if arrSelectedIndex.contains(indexPath) {
                    arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
                    selectedArrayData.indices.forEach { i in
                        if selectedArrayData[i].id == strData.id
                        {
                            indexForRemove = i
                        }
                    }
                    selectedArrayData.remove(at: indexForRemove!)
                }
                else {
                    arrSelectedIndex.append(indexPath)
                    selectedArrayData.append(strData)
                }

                collectionView.reloadData()
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width/3.3, height: UIScreen.main.bounds.width/3.3)
    }
}

