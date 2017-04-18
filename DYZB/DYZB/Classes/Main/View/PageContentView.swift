//
//  PageContentView.swift
//  DYZB
//
//  Created by DM on 2016/11/16.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

let contentId = "cellid"

protocol PageContentViewDelegate : class{
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

class PageContentView: UIView {
    
    var childVcs:[UIViewController]
    weak var parentViewController:UIViewController?
    var satrtOffset : CGFloat = 0
    weak var delegete : PageContentViewDelegate?
    var isForbidScorollDelegate : Bool = false
    
    lazy var collectionView:UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentId)
        return collectionView
        }()
    
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs;
        self.parentViewController = parentViewController
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView{
    func setupUI(){
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: contentId, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

extension PageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScorollDelegate = false
        
        satrtOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //判断是都是点击事件
        if(isForbidScorollDelegate){return}
        
        var progress : CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex = 0
        
        let currentOffectX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffectX > satrtOffset
        { //左滑
            progress = currentOffectX / scrollViewW - floor(currentOffectX / scrollViewW)
            
            sourceIndex = Int(currentOffectX / scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            
            if currentOffectX - satrtOffset == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        else
        {
            progress = 1 - (currentOffectX / scrollViewW - floor(currentOffectX / scrollViewW))
            
            targetIndex = Int(currentOffectX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
        }
        
        
        print("progress\(progress)  sourceIndex\(sourceIndex)  targetIndex\(targetIndex)")
        delegete?.pageContentView(contentView: self, progress: progress,sourceIndex: sourceIndex,targetIndex: targetIndex)
    }
    
}

extension PageContentView{
    func setCurrentIndex(currentIndex:Int){
        
        isForbidScorollDelegate = true
        
        let offsetX = collectionView.frame.width * CGFloat(currentIndex)
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false
        )
    }
}
