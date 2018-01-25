//
//  AppDelegate.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/16.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
  
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = BaseTabBarController()
        
        addNotification()
        setupRealm()
        setNav()
        window?.makeKeyAndVisible()
 
        return true
    }
    func setupRealm() {
        var realmConfig = try!Realm().configuration
        realmConfig.fileURL = realmConfig.fileURL!.deletingLastPathComponent().appendingPathComponent("myusername.realm")
        Realm.Configuration.defaultConfiguration = realmConfig
    }
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(presentPlayer(_:)), name: NSNotification.Name(KPresentPlayer), object: nil)
    }
    func setNav() {
        let navbar = UINavigationBar.appearance(whenContainedInInstancesOf: [BaseNavigationController.self])
        let titleAttribute = [NSAttributedStringKey.foregroundColor: KSubjectColor,
                              NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        navbar.titleTextAttributes = titleAttribute
    }

}
//MARK: 事件抽取
extension AppDelegate {
    @objc func presentPlayer(_ noti: Notification) {
        guard let albumId = noti.userInfo!["albumId"] as? String else {return}
        guard let trackId = noti.userInfo!["trackId"] as? String else {return}
        let downloadUrl = noti.userInfo!["downloadUrl"] as? String
        let player = ZFPlayerVC.shareInstance
        player.tableView.contentOffset.y = -64
        let nav = BaseNavigationController(rootViewController: player)
        if trackId == player.trackId {
            window?.rootViewController?.present(nav, animated: true, completion: nil)
        }else {
            ZFTabBarMiddleView.shareInstance.setPlayInfo(albumId, trackId)
            player.resetData(albumId,trackId, downloadUrl)
            window?.rootViewController?.present(nav, animated: true, completion: nil)

        }
  
    }
}

