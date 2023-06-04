//
//  ProductDetailViewController.swift
//  WasteManagement
//
//  Created by Rencheeraj Mohan on 03/06/23.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var productDetailCollectionView: UICollectionView!
    var displayData : [FeaturedProduct]?
    let collectionViewHeaderReuseIdentifier = "ProductHeaderView"
    override func viewDidLoad() {
        super.viewDidLoad()

//         Do any additional setup after loading the view.
        productDetailCollectionView.register(UINib(nibName: "ProductHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductHeaderView")
        setupCollectionView()
        
    }
    func setupCollectionView() {
        self.productDetailCollectionView.delegate = self
        self.productDetailCollectionView.dataSource = self
        self.productDetailCollectionView.register(UINib(nibName: "FeaturedProductDataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedProductDataCollectionViewCell")
        self.productDetailCollectionView.reloadData()
    }
    
}
extension ProductDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return displayData!.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayData![section].products.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
          case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(
              ofKind: kind,
              withReuseIdentifier: "\(ProductHeaderView.self)",
              for: indexPath) as? ProductHeaderView
            guard let typedHeaderView = headerView
            else { return headerView! }
            typedHeaderView.headerTitle?.text = displayData![indexPath.section].name
            return typedHeaderView
          default:
            assert(false, "Invalid element type")
          }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedProductDataCollectionViewCell", for: indexPath) as? FeaturedProductDataCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.featuredProductDataTitle.text = displayData?[indexPath.section].products[indexPath.row].product_name
        let url = URL(string: displayData?[indexPath.section].products[indexPath.row].images ?? "")
        cell.featuredProductDataImage.kf.setImage(with: url)
        cell.featuredProductDataUnitPrice?.text = " \(displayData![indexPath.section].products[indexPath.row].price) / \(displayData![indexPath.section].products[indexPath.row].unit)"
        setSandL(cell: cell)
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
    
    
}
extension ProductDetailViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width/3.3, height: UIScreen.main.bounds.width/3.3)
    }
}
