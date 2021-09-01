//
//  RecommendFunnyViewController.swift
//  DYZB
//
//  Created by LYW on 2021/6/3.
//

import UIKit

private let KtopMargin : CGFloat = 8


class RecommendFunnyViewController: BaseAnchorViewController {

    lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

extension RecommendFunnyViewController {
    
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: KtopMargin, left: 0, bottom: 0, right: 0)
    }
    
    override func requestData() {
        
        baseVM = funnyVM
        
        funnyVM.requestFunnyData {
            self.collectionView.reloadData()
        }
    }
}

