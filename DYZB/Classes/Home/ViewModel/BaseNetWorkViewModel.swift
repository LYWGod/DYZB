//
//  BaseNetWorkTool.swift
//  DYZB
//
//  Created by LYW on 2021/6/7.
//

import UIKit

class BaseNetWorkViewModel: NSObject {
    
    lazy var anchorGroup : [AnchorGroup] = [AnchorGroup]()

    func loadAnchorData(isGroup:Bool,url:String,parameters:[String:Any]? = nil,finishedCallBack:@escaping()->()) {
    
        AlamofireTool.requestWithUrl(funUrlStr: url, type: MethodType.get, parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }

            if isGroup {
                
                let group = AnchorGroup()
                
                for dict in dataArray {
                    
                    group.anchors.append(AnchorModel(dict: dict))
                    
                }
                
                self.anchorGroup.append(group)
                
            }else{
                
                for dict in dataArray {
                    self.anchorGroup.append(AnchorGroup(dict: dict))
                }
            }
            
            finishedCallBack()
        }
    }
}
