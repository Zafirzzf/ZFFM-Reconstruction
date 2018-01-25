//
//  BaseNavigationController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = KSubjectColor
        self.interactivePopGestureRecognizer?.delegate = self
        
    }
   
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let fixSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixSpaceItem.width = -15
            viewController.navigationItem.leftBarButtonItems = [fixSpaceItem,backButtonItem()]
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    @objc fileprivate func back() {
        popViewController(animated: true)
    }
    @objc func backButtonItem() -> UIBarButtonItem {
        let button = UIButton(title: "返回", normalTitleColor: KSubjectColor, highlightTitleColor: UIColor.lightGray, normalImage: #imageLiteral(resourceName: "back"))
        button.imageEdgeInsets = UIEdgeInsetsMake(3, 2, 3, 2)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }
    
    
    @objc func toRoot() {
        popToRootViewController(animated: true)
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count > 1
    }
}
