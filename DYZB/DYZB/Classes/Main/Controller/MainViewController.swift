//
//  MainViewController.swift
//  DYZB
//
//  Created by DM on 2016/11/16.
//  Copyright © 2016年 DM. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChileVc(storyName: "Home")
        addChileVc(storyName: "Live")
        addChileVc(storyName: "Follow")
        addChileVc(storyName: "Profile")
        
    }
    
    private func addChileVc(storyName:String){
        let childVc = UIStoryboard(name:storyName, bundle:nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }

}
