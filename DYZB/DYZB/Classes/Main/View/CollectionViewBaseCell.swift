//
//  CollectionViewBaseCell.swift
//  DYZB
//
//  Created by DM on 2016/11/23.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewBaseCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor:AnchorModel?{
        didSet{
            
            //0.校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            //1.取出在线人数显示文字
            var onlineStr :String = ""
            if anchor.online > 10000{
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }
            else
            {
                onlineStr = "\(anchor.online)在线"
            }
            
//            onlineButton.setTitle(onlineStr, for: .normal)
            
            //2.昵称的显示
//            nickNameLabel.text = anchor.nickname
            
            //3.设置封面图片
            let iconUrl = URL(string: anchor.vertical_src)!
            iconImageView.kf.setImage(with: iconUrl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
