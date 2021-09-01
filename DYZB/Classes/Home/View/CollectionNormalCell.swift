//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by LYW on 2021/5/27.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet{
            guard let anchor = anchor else { return }
            self.nickNameLabel.text = anchor.nickname
            let onlineStr = "\(anchor.online)" + "人在看"
            self.onlineBtn.setTitle(onlineStr, for: .normal)
            self.roomNameLabel.text = anchor.room_name
            guard let urlStr = URL(string: anchor.vertical_src) else { return }
            self.iconImageView.kf.setImage(with:urlStr, placeholder: UIImage(named: "Img_default"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

}
