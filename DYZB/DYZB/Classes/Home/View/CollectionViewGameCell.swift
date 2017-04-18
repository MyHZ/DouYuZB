//
//  CollectionViewGameCell.swift
//  DYZB
//
//  Created by DM on 2016/11/24.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var group:AnchorGroup?{
        didSet{
            
            titleLabel.text = group?.tag_name
            let iconUrl = URL(string: group?.icon_url ?? "推荐常用更多")
            iconImageView.kf.setImage(with: iconUrl)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
    }

}
