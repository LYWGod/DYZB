//
//  titlePageView.swift
//  DYZB
//
//  Created by LYW on 2021/5/10.
//

import UIKit

protocol TitlePageViewDelegate : NSObjectProtocol{
    func titlePageViewTitleLabelClick(titlePageView : TitlePageView,Index : Int)
}

private let lineHeight : CGFloat = 2
private let KNormalColor : (CGFloat,CGFloat,CGFloat) = (85, 85, 85)
private let KSelectedColor : (CGFloat,CGFloat,CGFloat) = (255, 128, 0)

class TitlePageView: UIView {

    private var currentIndex : Int = 0
    
    private let titles : [String]
    
    private var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollLineView : UIView = {
        let scrollLineView = UIView()
        scrollLineView.backgroundColor = UIColor.orange
        return scrollLineView
    }()
    
    weak var delegate : TitlePageViewDelegate?
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    init(frame: CGRect,titils:[String]) {
        
        self.titles = titils
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitlePageView {
    
    private func setupUI() {
        
        addSubview(scrollView)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: frame.height)
         
        setupTitleLabel()
        
        setupTitleLine()
        
        setupScrollLine()
    }
    
    private func setupTitleLabel(){
        let Y : CGFloat = 0
        let W : CGFloat = kScreenW/CGFloat(titles.count)
        let H : CGFloat = frame.height - lineHeight
        
        for (index,title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 17)
            titleLabel.textColor = UIColor.lightGray
            titleLabel.text = title
            titleLabel.tag = index
            titleLabel.textAlignment = .center

            let X : CGFloat = W * CGFloat(index)
            titleLabel.frame = CGRect(x: X, y: Y, width: W, height: H)
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            
            titleLabel.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(TitlePageView.titleLabelTapClick(tapGes:)))
            titleLabel.addGestureRecognizer(tap)
        }
    }
    
    private func setupTitleLine(){
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y: frame.height - lineHeight, width: frame.width, height: lineHeight)
        lineView.backgroundColor = UIColor.lightGray
        scrollView.addSubview(lineView)
    }
    
    private func setupScrollLine(){
        
        guard let firstLabel = titleLabels.first else { return }
        
        firstLabel.textColor = UIColor(R: KSelectedColor.0, G: KSelectedColor.1, B: KSelectedColor.2)
        
        scrollView.addSubview(scrollLineView)
        
        scrollLineView.frame = CGRect(x: 0, y: frame.height - lineHeight, width: firstLabel.frame.width, height: lineHeight)
    }
}


extension TitlePageView {
    @objc private func titleLabelTapClick(tapGes:UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        if currentLabel.tag == currentIndex { return }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor(R: KSelectedColor.0, G: KSelectedColor.1, B: KSelectedColor.2)
        
        oldLabel.textColor = UIColor(R: KNormalColor.0, G: KNormalColor.1, B: KNormalColor.2)
        
        currentIndex = currentLabel.tag
                
        let scrollX = CGFloat(currentLabel.tag) * scrollLineView.frame.width

        UIView.animate(withDuration: 0.25) {
            self.scrollLineView.frame.origin.x = scrollX
        }
        
        delegate?.titlePageViewTitleLabelClick(titlePageView: self, Index: currentIndex)
    }
}


extension TitlePageView {
    
    func setTitleWithProgress(progressValue:CGFloat,targetIndex:Int,startIndex:Int) {
        
        let startLabel = titleLabels[startIndex]
        
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - startLabel.frame.origin.x
        
        let moveX = progressValue * moveTotalX
        
        scrollLineView.frame.origin.x = startLabel.frame.origin.x + moveX
        
        let colorDelta = (KSelectedColor.0 - KNormalColor.0,
                          KSelectedColor.1 - KNormalColor.1,
                          KSelectedColor.2 - KNormalColor.2)
        
        startLabel.textColor = UIColor(R: KSelectedColor.0 - colorDelta.0 * progressValue,
                                       G: KSelectedColor.1 - colorDelta.1 * progressValue,
                                       B: KSelectedColor.2 - colorDelta.2 * progressValue)
        
        targetLabel.textColor = UIColor(R: KNormalColor.0 + colorDelta.0 * progressValue,
                                       G: KNormalColor.1 + colorDelta.1 * progressValue,
                                       B: KNormalColor.2 + colorDelta.2 * progressValue)
        currentIndex = targetIndex
        
    }
}

