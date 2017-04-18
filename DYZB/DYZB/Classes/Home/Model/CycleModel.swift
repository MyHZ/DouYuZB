//
//  CycleModel.swift
//  DYZB
//
//  Created by DM on 2016/11/23.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    //标题
    var title:String = ""
    //展示的图片地址
    var pic_url:String = ""
    //主播信息对应的字典
    var room:[String:Any]?{
        didSet{
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict:room)
        }
    }
    //主播信息对应的模型对象
    var anchor:AnchorModel?
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
