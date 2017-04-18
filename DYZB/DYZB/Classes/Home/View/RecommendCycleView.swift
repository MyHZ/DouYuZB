//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by DM on 2016/11/23.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit
import SnapKit

let kCycleCellId = "kCycleCellId"


class RecommendCycleView: UIView {
    
    var cycleTimer: Timer?
    
    var cycleModles : [CycleModel]? {
        didSet{
            collectionView.reloadData()
            
            
            pageControll.numberOfPages = cycleModles?.count ?? 0
            
            //默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModles?.count ?? 0 ) * 10, section:0)
            collectionView.scrollToItem(at: indexPath , at: UICollectionViewScrollPosition.left, animated: false)
        
            //添加定时器
            removeTimer()
            addCycleTimer()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        collectionView.register(UINib.init(nibName:"CollectionViewCycleCell", bundle: nil) , forCellWithReuseIdentifier: kCycleCellId)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
    }
    
}

extension RecommendCycleView{
    func setUpUI() {
        
        
        
        pageControll.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-3)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.bottom.equalTo(self).offset(3)
        }
    }
}

extension RecommendCycleView
{
    class func recommedCycleView() ->RecommendCycleView{
        
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModles?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! CollectionViewCycleCell
        
        let cycleModel = cycleModles![indexPath.item % (cycleModles?.count)!]
        cell.cycleModel = cycleModel
        
        return cell
    }
}

extension RecommendCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        
        pageControll.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModles?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
}

//
extension RecommendCycleView{
    func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    func removeTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc private func scrollToNext(){
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
    }
    
}
