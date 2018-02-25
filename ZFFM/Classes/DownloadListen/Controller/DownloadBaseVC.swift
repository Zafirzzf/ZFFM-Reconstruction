//
//  DownloadNoDataVC.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
enum TableViewDataState {
    case loadingData
    case emptyData
    case abnormal
}

class DownloadBaseVC: UITableViewController {

    var dataState: TableViewDataState = .loadingData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: KDownloadListChange), object: nil)
        tableView.backgroundColor = UIColor(hex: "#e1e1e1")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    @objc dynamic func loadData() {
        tableView.reloadData()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


//MARK:- 代理 -- emptyTableView
extension DownloadBaseVC: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        switch dataState {
        case .emptyData:
            return UIImage(named: "noData_downloading")!
        case .loadingData:
            return #imageLiteral(resourceName: "placeholder")
        case .abnormal:
            return #imageLiteral(resourceName: "placeholder")

        }
    }
    func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        
        animation.duration = 1
        animation.repeatCount = MAXFLOAT
        return animation
    }
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        switch dataState {
        case .emptyData:
            return NSAttributedString(string: "去看看", attributes: [NSAttributedStringKey.foregroundColor: UIColor.orange, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        case .loadingData:
            return NSAttributedString(string: "")
        case .abnormal:
            return NSAttributedString(string: "网络出现异常,点击重试")
        }
    }
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        switch dataState {
        case .emptyData:
            navigationController?.pushViewController(ListenTodayFireVC(), animated: true)
        case .loadingData: break
        case .abnormal:
            print("尝试了重新连接")
            
        }
    }
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return dataState == .loadingData
    }
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(hex: "#dfdfdf")
    }
    
    
}



