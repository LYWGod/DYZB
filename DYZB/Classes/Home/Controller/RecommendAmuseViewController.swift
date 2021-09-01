//
//  RecommendAmuseViewController.swift
//  DYZB
//
//  Created by LYW on 2021/6/3.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class RecommendAmuseViewController: BaseAnchorViewController {

    private lazy var amuseHeadView : AmuseHeadView = {
        let amuseHeadView = AmuseHeadView.amuseHeadView()
        amuseHeadView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return amuseHeadView
    }()
    
    lazy var amuseVM : AmuseViewModel = AmuseViewModel()

}

extension RecommendAmuseViewController {
  
    override func setupUI() {
    
        super.setupUI()
        
        collectionView.addSubview(amuseHeadView)

        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }

    override func requestData()  {

        baseVM = amuseVM
        
        amuseVM.requestAmuseData {

            var anchorGroup = self.amuseVM.anchorGroup
            anchorGroup.removeFirst()
            self.amuseHeadView.group = anchorGroup

            self.collectionView.reloadData()
        }
    }
}
