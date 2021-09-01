//
//  RecommendViewController.swift
//  DYZB
//
//  Created by LYW on 2021/5/27.
//

import UIKit


private let kBannerViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 100


class RecommendViewController: BaseAnchorViewController {

    private lazy var bannerView : BannerView = {
        let bannerView = BannerView.bannerView()
        bannerView.frame = CGRect(x: 0, y: -kBannerViewH-kGameViewH, width: kScreenW, height: kBannerViewH)
        return bannerView
    }()
    
    private lazy var gameView : GameView = {
        let gameView = GameView.gameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    private lazy var viewModel : RecommendViewModel = RecommendViewModel()
    
}

extension RecommendViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(bannerView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kBannerViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
    
    override func requestData() {
        
        baseVM = viewModel
        
        viewModel.requestData { [self] in
            collectionView.reloadData()
            
            var groups = self.viewModel.anchorGroup
            
            groups.removeFirst()
            groups.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.anchorGroup = groups
            
        }
        
        viewModel.requeseBannerData {
            self.bannerView.banners = self.viewModel.bannerModels
        }
        
    }
}


extension RecommendViewController  {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let anchorGroup = viewModel.anchorGroup[indexPath.section]
        let anchor = anchorGroup.anchors[indexPath.row]
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellID , for: indexPath) as! CollectionPrettyCell
            cell.anchor = anchor
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            cell.anchor = anchor
            return cell
        }
    }
 
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
