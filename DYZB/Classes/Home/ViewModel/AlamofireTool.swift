//
//  AlamofireTool.swift
//  DYZB
//
//  Created by LYW on 2021/6/7.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class AlamofireTool : NSObject {
    
    
    
    class func requestWithUrl(funUrlStr:String,type:MethodType,parameters:[String:Any]? = nil,finishedCallBack:@escaping(_ result:Any)->()) {

    
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(funUrlStr,method:method,parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else { return }
            
            finishedCallBack(result)
        }
        
    }
}
