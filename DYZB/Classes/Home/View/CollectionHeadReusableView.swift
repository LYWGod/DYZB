//
//  CollectionHeadReusableView.swift
//  DYZB
//
//  Created by LYW on 2021/5/27.
//

import UIKit


class CollectionHeadReusableView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var anchorGroup : AnchorGroup? {
        didSet{
            guard let anchorGroup = anchorGroup else { return }
            self.titleLabel.text = anchorGroup.tag_name
            self.iconImageView.image = UIImage(named: anchorGroup.icon_name)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
