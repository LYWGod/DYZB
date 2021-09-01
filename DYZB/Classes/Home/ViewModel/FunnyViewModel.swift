//
//  FunnyViewModel.swift
//  DYZB
//
//  Created by LYW on 2021/6/3.
//

import UIKit
import Alamofire

class FunnyViewModel :BaseNetWorkViewModel {
    
    func requestFunnyData(finishedCallBack:@escaping()->()) {
        
        let funUrlStr = "http://capi.douyucdn.cn/api/v1/getColumnRoom/2"
        
        let parameters = ["limit":30,"offset":0]
        
        loadAnchorData(isGroup: true, url: funUrlStr, parameters: parameters, finishedCallBack: finishedCallBack)
    }
    
//    lazy var anchorGroup : [AnchorGroup] = [AnchorGroup]()
//
//    func requestFunnyData(finishedCallBack:@escaping()->()) {
//
//
//        let funUrlStr = "http://capi.douyucdn.cn/api/v1/getColumnRoom/2"
//
//        let parameters = ["limit":30,"offset":0]
//
//        Alamofire.request(funUrlStr,method: .get,parameters: parameters).responseJSON { (response) in
//            guard let resultDict = response.value as? [String : NSObject] else { return }
//            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
//
//            // 2.1.创建组
//            let group = AnchorGroup()
//
//            // 2.2.遍历dataArray的所有的字典
//            for dict in dataArray {
//                group.anchors.append(AnchorModel(dict: dict))
//            }
//            // 2.3.将group,添加到anchorGroups
//            self.anchorGroup.append(group)
//
//            finishedCallBack()
//        }
//
//    }
}
