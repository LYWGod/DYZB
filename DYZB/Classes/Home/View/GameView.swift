//
//  GameView.swift
//  DYZB
//
//  Created by LYW on 2021/5/28.
//

import UIKit

private let gameCellID = "gameCellID"

class GameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var anchorGroup : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = AutoresizingMask()

        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gameCellID)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    }
}

extension GameView {
    class func gameView() -> GameView {
        return Bundle.main.loadNibNamed("GameView", owner: nil, options: nil)?.first as! GameView
    }
}

extension GameView : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroup?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellID, for: indexPath) as! GameCollectionViewCell

        cell.group = anchorGroup![indexPath.row]
        cell.isShowLine = true
        
        return cell
    }
}
