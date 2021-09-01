//
//  UIBarButtionItem-Extension.swift
//  DYZB
//
//  Created by LYW on 2021/5/10.
//

import UIKit

extension UIBarButtonItem {
    
    
    convenience init(imageName:String,heightImageName:String = "",size:CGSize = CGSize.zero) {
    
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if heightImageName != "" {
            btn.setImage(UIImage(named: heightImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        
        self.init(customView:btn)
        
    }
}
