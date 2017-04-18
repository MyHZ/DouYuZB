//
//  RecommendGameView.swift
//  DYZB
//
//  Created by DM on 2016/11/24.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

let KGameCellId = "KGameCellId"

class RecommendGameView: UIView {
    
    var groups:[AnchorGroup]?{
        didSet{
            
            groups?.removeFirst()
            groups?.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            
            groups?.append(moreGroup)
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
}

extension RecommendGameView
{
    class func recommendGameView()->RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as!RecommendGameView
    }
}

extension RecommendGameView{
    func setUpUI() {
        
        collectionView.register(UINib.init(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellId)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
    }
}

extension RecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: KGameCellId, for: indexPath) as! CollectionViewGameCell
        
        cell.group = groups?[indexPath.item]
        
        return cell
    }
}
