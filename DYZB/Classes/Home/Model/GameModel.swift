//
//  GameModel.swift
//  DYZB
//
//  Created by LYW on 2021/6/2.
//

import UIKit

class GameModel: NSObject {
    @objc var tag_name : String = ""
    @objc var pic_url : String = ""
    
    init(dict:[String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
