//
//  CollecetionHeaderView.swift
//  DYZB
//
//  Created by DM on 2016/11/17.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

class CollecetionHeaderView: UICollectionReusableView {

    //MARK:控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK定义模型属性
    var group: AnchorGroup? {
    
        didSet{
            
            guard let group = group else {
                return
            }
            
            titleLabel.text = group.tag_name
            iconImageView.image = UIImage(named: group.icon_Name)
        }
    }
    
    //MARK:- 系统的回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
