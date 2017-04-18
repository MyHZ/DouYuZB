//
//  AnchorGroup.swift
//  DYZB
//
//  Created by DM on 2016/11/22.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //该组对应的房间信息
    var room_list: [[String:NSObject]]?{
        didSet{

            guard let room_list = room_list  else {
                return
            }
            for dict in room_list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    //改组显示的标题
    var tag_name: String = ""
    //组显示的图标
    var icon_Name: String = "home_header_normal"
    //定义对应的图标
    var icon_url : String = ""
    
    //定义主播的模型对象数据
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    //MARK:- 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

    override init(){
        
    }
    
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list"{
            if let dataAry = value as? [[String:Any]]{
                for dict in dataAry {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }*/
}
