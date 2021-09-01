//
//  PageContentView.swift
//  DYZB
//
//  Created by LYW on 2021/5/11.
//

import UIKit

protocol PageContentViewDelegate : NSObjectProtocol {
    func pageContentViewScroll(progressValue:CGFloat,targetIndex:Int,startIndex:Int)
}

private let UICollectionViewCellID : String = "UICollectionViewCellID"

class PageContentView: UIView {

    weak var delegate : PageContentViewDelegate?
    private let childVcs : [UIViewController]
    private weak var parentVc : UIViewController?
    private var startOffsetX : CGFloat = 0
    private var isForbidScrollDelegate : Bool = false
    private lazy var collectionView:UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kScreenW, height: kScreenH - kStatusBarHeight - kNavigationBarHeight - 28 - 44)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCellID)
        return collectionView
    }()
    
    
    init(frame: CGRect,childVcs: [UIViewController],parentVc: UIViewController?) {
        
        self.childVcs = childVcs
        
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    private func setupUI() {
        for childVc in childVcs {
            parentVc?.addChild(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVcs[(indexPath as NSIndexPath).item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate { return }
        
        var startIndex : Int = 0
        var targetIndex : Int = 0
        var progressValue : CGFloat = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.frame.width
        if currentOffsetX > startOffsetX  { //左滑
            
            progressValue = (currentOffsetX / scrollViewWidth) - floor(currentOffsetX / scrollViewWidth)
            startIndex =  Int(currentOffsetX / scrollViewWidth)
            targetIndex = startIndex + 1
            
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            
            if (currentOffsetX - startOffsetX == scrollViewWidth)  {
                progressValue = 1
                targetIndex = startIndex
            }
            
        }else{//右滑
            progressValue = 1 - (currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth))
                                 
            targetIndex = Int(currentOffsetX / scrollViewWidth)
            startIndex = targetIndex + 1
            if startIndex >= childVcs.count {
                startIndex = childVcs.count - 1
            }
        }
        
        delegate?.pageContentViewScroll(progressValue: progressValue, targetIndex: targetIndex, startIndex: startIndex)
    }
}

extension PageContentView {
    func setupCurrentIndex(currentIndex:Int) {
        
        isForbidScrollDelegate = true
        
        let contentX = CGFloat(currentIndex) * kScreenW
        
        collectionView.setContentOffset(CGPoint(x: contentX, y: 0), animated: false)
        
    }
}
