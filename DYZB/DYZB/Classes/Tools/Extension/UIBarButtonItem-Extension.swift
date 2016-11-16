//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by DM on 2016/11/16.
//  Copyright © 2016年 DM. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    /*
    class func createItem(imageName:String,highImageNmae:String,size:CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highImageNmae), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView:btn)
    }
     */
    convenience init(imageName:String,highImageNmae:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        if highImageNmae != "" {
            btn.setImage(UIImage(named:highImageNmae), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }
        else
        {
           btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:btn)
    }
}
