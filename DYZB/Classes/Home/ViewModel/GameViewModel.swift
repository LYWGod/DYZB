//
//  GameViewModel.swift
//  DYZB
//
//  Created by LYW on 2021/6/2.
//

import UIKit
import Alamofire

class GameViewModel : BaseNetWorkViewModel {
    
//    lazy var games : [AnchorGroup] = [AnchorGroup]()

    func requesetGameData(finishedCallBack:@escaping()->()) {
        
        let gameUrlStr = "http://capi.douyucdn.cn/api/v1/getHotRoom/2"
//这个接口报错了暂时先用其他接口代替："http://capi.douyucdn.cn/api/v1/getColumnDetail"
//let parameters = ["shortName" : "game"]
        
        loadAnchorData(isGroup: false, url: gameUrlStr, finishedCallBack: finishedCallBack)
    
//        Alamofire.request(gameUrlStr,method: .get).responseJSON { [self] (response) in
//
//            guard let resultDict = response.result.value as? [String:NSObject] else {return}
//
//            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
//
//            for dict in dataArray{
//                self.games.append(AnchorGroup(dict: dict))
//            }
//
//            finishedCallBack()
//        }
    }
}
