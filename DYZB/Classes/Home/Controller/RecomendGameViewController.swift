//
//  RecomendGameViewController.swift
//  DYZB
//
//  Created by LYW on 2021/6/2.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let KItemWidth : CGFloat = (kScreenW - 2 * kItemMargin) / 3
private let KItemHeight : CGFloat = KItemWidth * 6 / 5
private let KHeadViewHeight : CGFloat = 50

private let kGameViewH : CGFloat = 100

private let KItemGameCellID = "KItemGameCellID"
private let KItemGameHeadID = "KItemGameHeadID"

class RecomendGameViewController: UIViewController {

    private lazy var gameVM : GameViewModel = GameViewModel()
    private lazy var games : [AnchorGroup] = [AnchorGroup]()
    
    private lazy var topHeadView : TopHeadView = {
       let topHeadView = TopHeadView(frame: CGRect(x: 0, y: -KHeadViewHeight-kGameViewH, width: kScreenW, height: KHeadViewHeight))
        return topHeadView
    }()
    
    private lazy var gameView : GameView = {
        let gameView = GameView.gameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemWidth, height: KItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: KHeadViewHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
    
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KItemGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeadReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KItemGameHeadID)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        requestData()
    }
    
}

extension RecomendGameViewController {
    func setupUI() {
        
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeadView)

        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: KHeadViewHeight+kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
    func requestData() {
        gameVM.requesetGameData {

            self.games = self.gameVM.anchorGroup
            
            self.games.removeFirst()
            
            self.gameView.anchorGroup = Array(self.games[0..<10])
            
            self.collectionView.reloadData()
        }
    }
}

extension RecomendGameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KItemGameCellID, for: indexPath) as! GameCollectionViewCell

        cell.group = games[indexPath.item]
        cell.isShowLine = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KItemGameHeadID, for: indexPath) as! CollectionHeadReusableView
        headView.titleLabel.text = "全部"
        headView.iconImageView.image = UIImage(named: "Img_orange")
        headView.moreBtn.isHidden = true
        
        return headView
    }
    
}




