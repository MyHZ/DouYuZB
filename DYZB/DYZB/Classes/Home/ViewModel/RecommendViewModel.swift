//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by DM on 2016/11/22.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
    //懒加载属性
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    lazy var bigDataGroup:AnchorGroup = AnchorGroup()
    lazy var prettyGroup:AnchorGroup = AnchorGroup()
    lazy var cycleModels:[CycleModel] = [CycleModel]()
}

//MARK:-发送网络请求
extension RecommendViewModel{
    //请求推荐数据
    func requestData(finishCallBack:@escaping ()->()){
        
        //0 定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate .getCurrentTime()]
        
        //2.创建group
        let groupDisPatch = DispatchGroup()
        
        groupDisPatch.enter()
        //1.请求0部分推荐数据
        NetworkTools.SendRequest(methodType: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: ["time":NSDate.getCurrentTime()]) { (result) in
            
            //将result 转字典类型
            guard let resultDic =  result            as? [String: Any] else{ return}
            guard let dataAry  =  resultDic["data"] as? [[String: Any]] else{return}
            
            //3.1创建组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_Name = "home_header_hot"
            //3.2 遍历字典，并且转模型对象
            for dict in dataAry {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.3离开组
            groupDisPatch.leave()
            print("请求到 0")
        }
        
        //4.请求1部分颜值数据
        groupDisPatch.enter()
        NetworkTools.SendRequest(methodType: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params:parameters) { (result) in
            
            //将result 转字典类型
            guard let resultDic =  result            as? [String: Any] else{ return}
            
            guard let dataAry  =  resultDic["data"] as? [[String: Any]] else{return}
            
            //3.1创建组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_Name = "home_header_phone"
            //3.2遍历字典，并且转模型对象
            for dict in dataAry {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //3.2离开组
            groupDisPatch.leave()
            print("请求到 1")
        }
        
        //5.请求2-12部分游戏数据
        groupDisPatch.enter()
        NetworkTools.SendRequest(methodType: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", params:parameters) { (result) in
            
            //将result 转字典类型
            guard let resultDic =  result            as? [String: Any] else{ return}
            
            guard let dataAry  =  resultDic["data"] as? [[String: Any]] else{return}
            
            //遍历数组 获取字典
            for groupDic in dataAry{
                
                let group = AnchorGroup.init(dict: groupDic)
                
                self.anchorGroups.append(group)
            }
            //3.4离开组
            groupDisPatch.leave()
            print("请求到 2-12")
        }
        
        //6.所有的数组都请求到，之后进行排序
        groupDisPatch.notify(queue: DispatchQueue.main) {
            print("所有的数据都请求到")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }
    }
    //请求无线轮播数据
    func requestCycleData(finishCallBack:@escaping ()->()){
        NetworkTools.SendRequest(methodType: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6", params: ["version":"2.300"]) { (result) in
            
            guard let resultDic = result as? [String:Any] else{return}
            guard let dataAry = resultDic["data"] as? [[String:Any]] else{return}
            
            //字典转模型
            for dict in dataAry{
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallBack()
            
        }
    }
}
