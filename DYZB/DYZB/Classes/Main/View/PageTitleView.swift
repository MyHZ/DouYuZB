//
//  PageTitleView.swift
//  DYZB
//
//  Created by DM on 2016/11/16.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class{
    func pageTitleView(titleView:PageTitleView,selectedIndex index:Int)
}

//定义常量
let kScrollLineH : CGFloat = 2
let kNormaleColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)


//定义类
class PageTitleView: UIView {
    
    var currentIndex:Int = 0
    var titles:[String]
    
    weak var delegate : PageTitleViewDelegate?
    
    lazy var titleLabels:[UILabel] = [UILabel]()
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = .orange
        return scrollLine
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
        setupBottomMenuAndScrollLine()
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
            label.textColor = UIColor(R: kNormaleColor.0, G: kNormaleColor.1, B: kNormaleColor.2)
            label.textAlignment = NSTextAlignment.center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(titleLableClick(tapGes:)))
            
            label.addGestureRecognizer(tapGes)
        }
    }
    
    func setupBottomMenuAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(R: kSelectColor.0, G: kSelectColor.1, B: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
    func titleLableClick(tapGes:UITapGestureRecognizer){
        print("titleLableClick")
        
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        //如果是重复点击同一个label，那么直接返回
        if currentLabel.tag == currentIndex {
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor(R: kSelectColor.0, G: kSelectColor.1, B: kSelectColor.2)
        oldLabel.textColor = UIColor(R: kNormaleColor.0, G: kNormaleColor.1, B: kNormaleColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLinePostion = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations:{
            self.scrollLine.frame.origin.x = scrollLinePostion
        })
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
    
}

extension PageTitleView{
    func setTitleWithProrgress(proress:CGFloat,sourceIndex:Int,targetIndex:Int){
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * proress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色的渐变
        //3.1取出颜色变化的范围
        let colorDelta = (kSelectColor.0 - kNormaleColor.0,kSelectColor.1 - kNormaleColor.1,kSelectColor.2 - kNormaleColor.2)
        //3.2变化
        sourceLabel.textColor = UIColor(R: kSelectColor.0 - colorDelta.0 * proress, G: kSelectColor.1 - colorDelta.1 * proress, B: kSelectColor.2 - colorDelta.2 * proress)
        
        //3.3
        targetLabel.textColor = UIColor(R: kNormaleColor.0 + colorDelta.0 * proress, G: kNormaleColor.1 + colorDelta.1 * proress, B: kNormaleColor.2 + colorDelta.2 * proress)
        
        currentIndex = targetIndex
        
    }
}


