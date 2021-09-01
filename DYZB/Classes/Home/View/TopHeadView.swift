//
//  TopHeadView.swift
//  DYZB
//
//  Created by LYW on 2021/6/2.
//

import UIKit
import SnapKit

class TopHeadView: UIView {
    
    var picture : UIImageView = UIImageView()

    var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        return titleLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopHeadView {
    func setupUI() {
        
        addSubview(picture)
        addSubview(titleLabel)
        
        picture.snp.makeConstraints { (make) in
            make.width.equalTo(4)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
            make.left.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picture.snp_right).offset(10)
            make.centerY.equalTo(picture.snp_centerY)
        }
        
        picture.image = UIImage(named: "Img_orange")
        titleLabel.text = "常见"
    }
}
