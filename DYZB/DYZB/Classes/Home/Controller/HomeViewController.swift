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
    
    lazy var pageTitleView:PageTitleView = { [weak self]in
        let titleFrame = CGRect(x: 0, y: kStatusBarh + kNavgationBarH, width: KScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContentView:PageContentView = {
        [weak self]in
        
        let contentHeight = kScreenH - (kStatusBarh + kNavgationBarH + kTitleViewH + kTabBarH)
        let contentFrame = CGRect.init(x: 0, y: kStatusBarh + kNavgationBarH + kTitleViewH, width: KScreenW, height: contentHeight)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(R: CGFloat(arc4random_uniform(255)), G: CGFloat(arc4random_uniform(255)), B: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView.init(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.backgroundColor = UIColor.purple
        contentView.delegete = self
        return contentView
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
        
        view.addSubview(pageContentView)
        
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

extension HomeViewController:PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProrgress(proress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


