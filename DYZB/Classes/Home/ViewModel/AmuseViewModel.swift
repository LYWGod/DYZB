//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by LYW on 2021/6/3.
//

import UIKit
import Alamofire

class AmuseViewModel: BaseNetWorkViewModel {

//    lazy var anchorGroup : [AnchorGroup] = [AnchorGroup]()
    
    func requestAmuseData(finishedCallBack:@escaping ()->()) {
        
        let amuseurlStr = "http://capi.douyucdn.cn/api/v1/getHotRoom/2"
        
        loadAnchorData(isGroup: false, url: amuseurlStr, finishedCallBack: finishedCallBack)
        
//        Alamofire.request(urlStr,method: .get).responseJSON { (response) in
//            guard let resultDict = response.value as? [String : NSObject] else { return }
//            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
//
//            for dict in dataArray {
//                self.anchorGroup.append(AnchorGroup(dict: dict))
//            }
//
//            finishedCallBack()
//
//        }
        
    }
}
