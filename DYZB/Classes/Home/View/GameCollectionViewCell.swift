//
//  GameCollectionViewCell.swift
//  DYZB
//
//  Created by LYW on 2021/5/28.
//

import UIKit
import Kingfisher

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
   
    var isShowLine : Bool?{
        didSet{
            guard let isShowLine = isShowLine else { return }
            bottomLine.isHidden = isShowLine
        }
    }
    
    var group : AnchorGroup?{
        didSet{
            guard let group = group else { return }
            nameLabel.text = group.tag_name
            if let iconURL = URL(string: group.icon_url) {
                pictureImageView.kf.setImage(with: iconURL)
            } else {
                pictureImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = AutoresizingMask()
    }

}
