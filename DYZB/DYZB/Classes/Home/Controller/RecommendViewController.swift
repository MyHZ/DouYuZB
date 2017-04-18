//
//  RecommendViewController.swift
//  DYZB
//
//  Created by DM on 2016/11/17.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit
import SnapKit

let kItemMargin : CGFloat = 10
let kItemW = (KScreenW - 3 * kItemMargin)/2
let kNormalItemH = kItemW * 3 / 4
let kPrettyItemH = kItemW * 4 / 3
let kHeadViewH:CGFloat = 50

let kNormalCellId = "kNormalCellId"
let kPrettyCellId = "kPrettyCellId"
let kHeaderViewID = "kHeaderViewID"

let kCycleViewH = KScreenW * 3 / 8
let kGameViewH:CGFloat = 90


class RecommendViewController: UIViewController {
    
    lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    lazy var collcetionView : UICollectionView = {[unowned self]in
        
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: KScreenW, height: kHeadViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //创建 UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)
        
        collectionView.register(UINib(nibName: "CollecetionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier : kHeaderViewID)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView
        }()
    
    lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommedCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH) , width: KScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: KScreenW, height: kGameViewH)
        
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.
        
        
        loadData()
        
        collcetionView.addSubview(cycleView)
        
        collcetionView.addSubview(gameView)
    }
}

extension RecommendViewController{
    func setupUI(){
        
        view.addSubview(collcetionView)
        
        collcetionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
        
    }
    
    
}

//请求数据
extension RecommendViewController{
    func loadData(){
        
        //1.请求推荐数据
        recommendViewModel.requestData {
            self.collcetionView.reloadData()
            
            //将数据展示给collec
            self.gameView.groups = self.recommendViewModel.anchorGroups
        }
        //2.请求轮播数据
        recommendViewModel.requestCycleData {
            print("数据请求完成")
            self.cycleView.cycleModles = self.recommendViewModel.cycleModels
        }
        
    }
}

extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let  group = recommendViewModel.anchorGroups[section]
        return group.anchors.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //0.取出模型对象
        let group = recommendViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        var cell:CollectionViewBaseCell!
        if indexPath.section == 1
        {
            cell = collectionView .dequeueReusableCell(withReuseIdentifier: kPrettyCellId , for: indexPath) as! CollectionViewPrettyCell
            
        }
        else
        {
            cell = collectionView .dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor = anchor
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollecetionHeaderView
        
        headerView.group = recommendViewModel.anchorGroups[indexPath.section]
        
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let itemH = indexPath.section == 1 ? kPrettyItemH : kNormalItemH
        return CGSize.init(width: kItemW, height: itemH)
    }
}
