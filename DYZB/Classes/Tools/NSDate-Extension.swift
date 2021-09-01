//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by LYW on 2021/5/27.
//

import Foundation

extension NSDate {
    
    static func currentDate() -> String {
        
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}

