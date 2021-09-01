//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by LYW on 2021/5/27.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    
    var anchor : AnchorModel? {
        didSet{
            guard let anchor = anchor else { return }
            let onlineStr = "\(anchor.online)" + "人在看"
            self.onlineBtn.setTitle(onlineStr, for: .normal)
            self.cityBtn.setTitle(anchor.anchor_city, for: .normal)
            self.roomNameLabel.text = anchor.room_name
            guard let urlStr = URL(string: anchor.vertical_src) else { return }
            self.iconImageView.kf.setImage(with:urlStr, placeholder: UIImage(named: "Img_default"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
