//
//  HomeViewController.swift
//  DYZB
//
//  Created by LYW on 2021/5/10.
//

import UIKit

let titlePageViewHeight : CGFloat = 44


class HomeViewController: UIViewController {

    private lazy var titlePageView : TitlePageView = { [weak self] in
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let frame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight + 28, width: UIScreen.main.bounds.size.width, height: titlePageViewHeight)
        let titlePageView = TitlePageView(frame: frame, titils: titles)
        titlePageView.delegate = self
        return titlePageView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        
        let Y = kStatusBarHeight + kNavigationBarHeight + 28 + titlePageViewHeight
        
        let frame = CGRect(x: 0, y:Y , width: kScreenW, height: kScreenH - Y)
        
        var childVcs : [UIViewController] = [UIViewController]()
    
        childVcs.append(RecommendViewController())
        childVcs.append(RecomendGameViewController())
        childVcs.append(RecommendAmuseViewController())
        childVcs.append(RecommendFunnyViewController())
//        for _ in 0..<1 {
//            let childVc = UIViewController()
//            childVc.view.backgroundColor = UIColor.randomColor()
//            childVcs.append(childVc)
//        }
        let pageContentView = PageContentView(frame: frame, childVcs: childVcs,parentVc:self)
        pageContentView.delegate = self
        
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension HomeViewController{
    private func setupUI() {
        setupNavBarItem()
        setupTitlePage()
        setupContentView()
    }
    
    private func setupNavBarItem() {
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "logo"), for: .normal)
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        

        let size : CGSize = CGSize(width: 40, height: 40)
        let searchItem = UIBarButtonItem(imageName: "btn_search", heightImageName: "btn_search_clicked", size: size)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", heightImageName: "image_my_history_clicked",size: size)
        let scannItem = UIBarButtonItem(imageName: "Image_scan", heightImageName: "Image_scan_clicked",size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,scannItem]
        
    }
    
    private func setupTitlePage() {
      
        view.addSubview(titlePageView)
    }
    
    private func setupContentView(){
        view.addSubview(pageContentView)
    }
}

extension HomeViewController : TitlePageViewDelegate {
    func titlePageViewTitleLabelClick(titlePageView: TitlePageView, Index: Int) {
        pageContentView.setupCurrentIndex(currentIndex: Index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentViewScroll(progressValue: CGFloat, targetIndex: Int, startIndex: Int) {
        
        titlePageView.setTitleWithProgress(progressValue: progressValue, targetIndex: targetIndex, startIndex: startIndex)
    }
}

