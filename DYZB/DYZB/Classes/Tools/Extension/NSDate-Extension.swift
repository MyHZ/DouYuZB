//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by DM on 2016/11/22.
//  Copyright © 2016年 DM. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String{
        
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
