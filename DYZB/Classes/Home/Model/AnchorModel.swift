//
//  AnchorModel.swift
//  DYZB
//
//  Created by LYW on 2021/5/28.
//

import UIKit

class AnchorModel: NSObject {
    //房间id
    @objc var room_id : Int = 0
    //图片
    @objc var vertical_src : String = ""
    //手机或者电脑在线
    @objc var isVertical : Int = 0
    //房间名
    @objc var room_name : String = ""
    //昵称
    @objc var nickname : String = ""
    //在线人数
    @objc var online : Int = 0
    //城市
    @objc var anchor_city : String = ""
    
    @objc var icon_url : String = ""
    
    init(dict : [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}
