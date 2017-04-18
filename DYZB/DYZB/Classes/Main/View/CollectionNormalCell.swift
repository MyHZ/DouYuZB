//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by DM on 2016/11/17.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionViewBaseCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor:AnchorModel?{
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
}
