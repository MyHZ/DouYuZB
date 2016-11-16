//
//  PageTitleView.swift
//  DYZB
//
//  Created by DM on 2016/11/16.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

let kScrollLineH:CGFloat = 2

class PageTitleView: UIView {
    
    var titles:[String]
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //MARK
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView{
    func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitlesLabels()
    }
    
    func setupTitlesLabels(){
        
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = frame.height-kScrollLineH
        let labelY:CGFloat = 0
        
        for(index,title) in titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = NSTextAlignment.center
            
            let labelX:CGFloat = labelW * CGFloat(index)
       
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
        }
    }
}
