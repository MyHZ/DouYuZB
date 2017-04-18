//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by DM on 2016/11/16.
//  Copyright © 2016年 DM. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    convenience init(R:CGFloat,G:CGFloat,B:CGFloat) {
        self.init(red: R / 255, green: G / 255, blue: B / 255, alpha: 1.0)
    }
}
