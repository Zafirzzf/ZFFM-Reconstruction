//
//  HomeRecommendCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/4.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
fileprivate let cellID = "recommondCellID"
fileprivate let itemCellID = "itemCellID"
fileprivate let KCellCountInRow: Int = 3
fileprivate let KCellMargin: CGFloat = 10
class HomeRecommendCell: UITableViewCell, LoadNibCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @objc var groupModel = HomeGroupModel() {
        didSet {
            titleLabel.text = groupModel.title
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        let itemW = (KSCREEN_W - CGFloat(KCellCountInRow + 1) * KCellMargin) / CGFloat(KCellCountInRow)
        let itemH = itemW * 1.6
        flowLayout.itemSize = CGSize(width: itemW, height: itemH )
        flowLayout.minimumLineSpacing = KCellMargin - 0.1
        flowLayout.minimumInteritemSpacing = KCellMargin - 0.1
        collectionView.contentInset = UIEdgeInsetsMake(0, KCellMargin, 0, KCellMargin)
        collectionView.register(UINib(nibName: "HomeItemCell", bundle: nil), forCellWithReuseIdentifier: itemCellID)
      
        
    }
    


    @IBAction func moreBtnClick(_ sender: Any) {
        
    }
    
}
//MARK:- collectionVie
extension HomeRecommendCell: UICollectionViewDelegate, UICollectionViewDataSource, PushAlbumDetail {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupModel.list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellID, for: indexPath) as! HomeItemCell
        cell.itemCellModel = groupModel.list[indexPath.item] as! HomeItemCellModel
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let itemModel = groupModel.list[indexPath.item] as! HomeItemCellModel
        let priceTypeId = itemModel.priceTypeId
        if priceTypeId == "0" || priceTypeId == "1" {
            pushAlbumDetailVC(itemModel.albumId)
            
        }
        
    }
    
}




