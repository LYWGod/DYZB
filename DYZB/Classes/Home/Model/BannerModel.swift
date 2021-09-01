//
//  BannerModel.swift
//  DYZB
//
//  Created by LYW on 2021/5/28.
//

import UIKit

class BannerModel: NSObject {

    @objc var title : String = ""
    
    @objc var pic_url : String = ""
    
    @objc var room : [String : NSObject]? {
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    // 主播信息对应的模型对象
    @objc var anchor : AnchorModel?
    
    init(dict:[String:NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
