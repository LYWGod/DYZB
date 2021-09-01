//
//  AnchorGroup.swift
//  DYZB
//
//  Created by LYW on 2021/5/28.
//

import UIKit

class AnchorGroup: NSObject {
    
    @objc var room_list : [[String : NSObject]]? {
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list {
                let anchor = AnchorModel(dict: dict)
                anchors.append(anchor)
            }
        }
    }
    //组图片
    @objc var icon_name : String = "home_header_normal"
    //组名
    @objc var tag_name : String = ""
    
    @objc var icon_url : String = ""
    
    @objc var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {}
    
    init(dict : [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
