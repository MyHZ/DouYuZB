//
//  AnchorModel.swift
//  DYZB
//
//  Created by DM on 2016/11/22.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间id
    var room_id : Int = 0
    //房间图片对应的url
    var vertical_src : String = ""
    //判断是手机还是电脑直播
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //观看人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
