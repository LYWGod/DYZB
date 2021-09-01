//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by LYW on 2021/5/27.
//

import UIKit
import Alamofire

class RecommendViewModel: BaseNetWorkViewModel {
    
//    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var gameDataGroup : AnchorGroup = AnchorGroup()
    lazy var bigDataCroup : AnchorGroup = AnchorGroup()
    lazy var prettyDataCroup : AnchorGroup = AnchorGroup()
    
    lazy var bannerModels : [BannerModel] = [BannerModel]()
}


extension RecommendViewModel {
    func requestData(finishedCallBack: @escaping()->()) {
        
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.currentDate()]
        
        let group = DispatchGroup()
        
        // 请求第一部分推荐数据
        let recommendString = "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
        
        let recommendParameters = ["time":NSDate.currentDate()]
    
        group.enter()
        
        Alamofire.request(recommendString,method: .get,parameters: recommendParameters).responseJSON { (response) in
            
            guard let resultDict = response.result.value as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }

            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataCroup.anchors.append(anchor)
            }
            
            self.bigDataCroup.icon_name = "home_header_hot"
            self.bigDataCroup.tag_name = "热门"
            
            print("----请求第一部分推荐数据完成---")
            group.leave()
                
        }
        
        // 请求第二部分颜值数据
        let prertyString = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
        
        group.enter()
        
        Alamofire.request(prertyString,method: .get,parameters: parameters).responseJSON { (response) in
        
            guard let resultDict = response.result.value as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyDataCroup.anchors.append(anchor)
            }
            self.prettyDataCroup.icon_name = "home_header_phone"
            self.prettyDataCroup.tag_name = "颜值"
            
            print("+++请求第二部分颜值数据完成+++")
            
            group.leave()
            
        }
        
        // 请求2-12部分游戏数据
        let gameSting = "http://capi.douyucdn.cn/api/v1/getHotCate"
        
        group.enter()
        
        loadAnchorData(isGroup: false, url: gameSting, parameters: parameters) {
            group.leave()
        }
        
//        Alamofire.request(gameSting,method: .get, parameters: parameters).responseJSON { (response) in
//
//            guard let resultDict = response.result.value as? [String : NSObject] else { return }
//
//            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
//
//            for dict in dataArray {
//                let anchorGroup = AnchorGroup(dict: dict)
//                self.anchorGroups.append(anchorGroup)
//            }
//
//            print("===请求2-12部分游戏数据完成===")
//
//            group.leave()
//
//        }
        
        group.notify(queue: .main) {

            self.anchorGroup.insert(self.prettyDataCroup, at: 0)
            self.anchorGroup.insert(self.bigDataCroup, at: 0)
            
            finishedCallBack()
        }
    }
    
    func requeseBannerData(finishedCallBack: @escaping()->()){
        
        let bannerStr = "http://www.douyutv.com/api/v1/slide/6"
        
        let parameters = ["version" : "2.300"]
        
        Alamofire.request(bannerStr,method: .get,parameters: parameters).responseJSON { (response) in
            
            guard let resultDict = response.result.value as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }

            for dict in dataArray {
                let bannerModel = BannerModel(dict: dict)
                self.bannerModels.append(bannerModel)
            }
            
            finishedCallBack()
        }
        
    }
}
