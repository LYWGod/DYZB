//
//  BannerView.swift
//  DYZB
//
//  Created by LYW on 2021/5/28.
//

import UIKit

private let collectionBannerCellID = "collectionBannerCellID"

class BannerView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var banners : [BannerModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
}

extension BannerView {
    
    class func bannerView() -> BannerView {
        return  Bundle.main.loadNibNamed("BannerView", owner: nil, options: nil)?.first as! BannerView
    }
    
    override func layoutSubviews() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = AutoresizingMask()
        
        collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: collectionBannerCellID)
    }
}

extension BannerView : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bannermodel = banners![indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionBannerCellID , for: indexPath) as! BannerCollectionViewCell
        
        cell.bannermodel = bannermodel
        
        return cell
    }
    
    
}
