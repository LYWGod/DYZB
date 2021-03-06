//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by LYW on 2021/5/11.
//

import UIKit


extension UIColor {
    
    convenience init(R:CGFloat,G:CGFloat,B:CGFloat) {
        
        self.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1)
    }
    
    class func randomColor() -> UIColor {
        
       return UIColor(R: CGFloat(arc4random_uniform(256)), G: CGFloat(arc4random_uniform(256)), B: CGFloat(arc4random_uniform(256)))
    }
}
