//
//  AmuseCollectionViewCell.swift
//  DYZB
//
//  Created by LYW on 2021/6/3.
//

import UIKit

private let amuseCellID = "amuseCellID"

class AmuseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
        
    var group : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = AutoresizingMask()
        
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: amuseCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = self.bounds.width / 4
        let height = self.bounds.height / 2
        layout.itemSize = CGSize(width: width, height: height)
    }

}

extension AmuseCollectionViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell  = collectionView.dequeueReusableCell(withReuseIdentifier: amuseCellID, for: indexPath) as! GameCollectionViewCell
        cell.group = group![indexPath.item]
        cell.isShowLine = false
        return cell
    }
}
