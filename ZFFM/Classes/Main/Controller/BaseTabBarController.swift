//
//  BaseTabBarController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import Pods_ZFFM
class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildVC()
        setValue(ZFTabBar(), forKey: "tabBar")
    }

    private func setupChildVC() {
        
        addChildVC("HomeViewController", "tabbar_find_n", "tabbar_find_h")
        addChildVC("TestViewController", "tabbar_sound_n", "tabbar_sound_h")
        addChildViewController(UIViewController())
        addChildVC("DownloadHomeVC", "tabbar_download_n", "tabbar_download_h")
        addChildVC("MineRootController", "tabbar_me_n", "tabbar_me_h")
    }

}


//MARK:- 抽取的方法
extension BaseTabBarController {
    fileprivate func addChildVC(_ vcString: String, _ normalImageName: String, _ selectedImageName: String) {
        guard let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else { //命名空间
            return
        }
        let vcClass: AnyClass? = NSClassFromString(spaceName + "." + vcString)
        guard let clsType = vcClass as? UIViewController.Type else {
            return
        }
        let vc = clsType.init()

        let normalImage = UIImage(named: normalImageName)?.withRenderingMode(.alwaysOriginal)
        let selectimage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        
        vc.tabBarItem = UITabBarItem(title: nil, image: normalImage, selectedImage: selectimage)
        let nav = BaseNavigationController(rootViewController: vc)
        addChildViewController(nav)
    }

}







