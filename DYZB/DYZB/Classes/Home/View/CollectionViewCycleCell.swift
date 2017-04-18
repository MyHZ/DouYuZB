//
//  CollectionViewCycleCell.swift
//  DYZB
//
//  Created by DM on 2016/11/23.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel:CycleModel?
        {
        didSet{
            titleLabel.text = cycleModel?.title
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconUrl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
