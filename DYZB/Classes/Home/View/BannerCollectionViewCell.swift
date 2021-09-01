//
//  BannerCollectionViewCell.swift
//  DYZB
//
//  Created by LYW on 2021/5/28.
//

import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pictureImgeView: UIImageView!
    
    var bannermodel : BannerModel?{
        didSet{
            guard let picStr = bannermodel?.pic_url else { return }
            guard let picUrl = URL(string: picStr) else { return }
            self.pictureImgeView.kf.setImage(with: picUrl, placeholder: UIImage(named: "Img_default"))   
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = AutoresizingMask()

    }

}
