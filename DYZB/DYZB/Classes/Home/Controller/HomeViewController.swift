//
//  HomeViewController.swift
//  DYZB
//
//  Created by DM on 2016/11/16.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

private var kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    lazy var pageTitleView:PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarh + kNavgationBarH, width: KScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        

    }
    
}


//MARK:--设置UI界面
extension HomeViewController{
    func setUpUI(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        setUpNavigationBar()
        
         view.addSubview(pageTitleView)
        
    }
    private func setUpNavigationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", highImageNmae: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.init(imageName: "btn_search", highImageNmae: "btn_search_clicked", size: size)
        let qrodeItem = UIBarButtonItem.init(imageName: "Image_scan", highImageNmae: "Image_scan_click", size: size)
     
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrodeItem]
    }
}
