//
//  CollectionViewPrettyCell.swift
//  DYZB
//
//  Created by DM on 2016/11/17.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

class CollectionViewPrettyCell: CollectionViewBaseCell {
    
    @IBOutlet weak var cityButton: UIButton!
    
    override var anchor:AnchorModel?{
        didSet{
            
            super.anchor = anchor
            cityButton.setTitle(anchor?.anchor_city, for: .normal)
        
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
