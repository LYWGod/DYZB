//
//  AmuseHeadView.swift
//  DYZB
//
//  Created by LYW on 2021/6/3.
//

import UIKit

private let amuseHeadCellID = "amuseHeadCellID"

class AmuseHeadView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!

    var group : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = AutoresizingMask()
        
        collectionView.register(UINib(nibName: "AmuseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: amuseHeadCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size
    }
}

extension AmuseHeadView {
    class func amuseHeadView() -> AmuseHeadView {
        return Bundle.main.loadNibNamed("AmuseHeadView", owner: nil, options: nil)?.first as! AmuseHeadView
    }
}

extension AmuseHeadView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if group?.count == nil { return 0 }
        let page = (group!.count - 1) / 8 + 1
        return page
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: amuseHeadCellID, for: indexPath) as! AmuseCollectionViewCell
        
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        if endIndex > group!.count - 1 {
            endIndex = group!.count - 1
        }
        
        cell.group = Array(group![startIndex...endIndex])
        
        return cell
    }
}

