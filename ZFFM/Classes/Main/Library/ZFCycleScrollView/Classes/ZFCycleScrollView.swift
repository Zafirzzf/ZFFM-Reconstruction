//
//  ZFCycleScrollView.swift
//  ZFCycleScrollView
//
//  Created by 周正飞 on 2017/6/29.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
fileprivate let cellID = "cellID"
@objc public protocol ZFCycleScrollViewDelegate {
    @objc optional func cycleScrollView(_ cycleScrollView: ZFCycleScrollView, didSelectItemAtIndex index: Int)
    @objc optional func cycleScrollView(_ cycleScrollView: ZFCycleScrollView, didScrolledToItemIndex index: Int)
}

public class ZFCycleScrollView: UIView{
    
    /* 懒加载控件*/
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = self.bounds.size
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumLineSpacing = 0
        return collectionLayout
    }()
    lazy var collectionView: UICollectionView = {
  
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ZFCycleCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        return pageControl
    }()
    
     var timer: Timer? = Timer()
    
    /* 暴露的属性 */
     open var delegate: ZFCycleScrollViewDelegate?
     open var placeHolderImage: UIImage? // 占位图
     open var pageDotColor: UIColor = UIColor.gray //
     open var currentPageDotColor: UIColor = UIColor.white {
        didSet {
            pageControl.currentPageIndicatorTintColor = currentPageDotColor
        }
    }
     open var pageAnimateInterval = 3.0
     open var picUrls:[String] = [] {
        didSet {
            setPicUrls(pics: picUrls)
        }
    }
    
    
    /* 构造方法 */
    public init(frame: CGRect, delegate: ZFCycleScrollViewDelegate? = nil, placeHolderImage: UIImage? = nil ) {
        super.init(frame: frame)
        self.delegate = delegate
        self.placeHolderImage = placeHolderImage
        setupUI()
        
        
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    override open func didMoveToSuperview() {
        if superview == nil {
            timer?.invalidate()
            timer = nil
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK:- UI
extension ZFCycleScrollView {
     func setupUI() {
        if let placeholderImages = placeHolderImage {
            backgroundColor = UIColor(patternImage: placeholderImages)
        }
        addSubview(collectionView)
        addSubview(pageControl)
    }
}
//MARK:- 添加计时器
extension ZFCycleScrollView {
    func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: pageAnimateInterval, target: self, selector: #selector(scrollBanner), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
        
    }
    @objc func scrollBanner() {
        let currentOffset = collectionView.contentOffset
        collectionView.setContentOffset(CGPoint(x: currentOffset.x + bounds.width, y: currentOffset.y), animated: true)
        
    }
}
//MARK:- 数据赋值
extension ZFCycleScrollView {
     func setPicUrls(pics: [String]) {
        collectionView.reloadData()
        let indexPath = IndexPath(item: picUrls.count * 100, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        if pics.count > 1 {
            setupPageControl()
            addTimer()
            collectionView.isScrollEnabled = true
        }
    }
    
    //显示pageControl
     func setupPageControl() {
        pageControl.frame = CGRect(x: 0, y: bounds.height - 20, width: bounds.width, height: 15)
        pageControl.numberOfPages = picUrls.count
        pageControl.currentPage = 0
        pageControl.isEnabled = false
        
    }
}

//MARK:- collectionView数据源与代理
extension ZFCycleScrollView: UICollectionViewDataSource,UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count * 10000
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)  as! ZFCycleCell
        cell.placeHolderImage = placeHolderImage
        cell.picUrl = picUrls[indexPath.item % picUrls.count]
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleScrollView?(self, didSelectItemAtIndex: indexPath.item % picUrls.count)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setscrollOffset(scrollView)
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        setscrollOffset(scrollView)
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       addTimer()
    }
    
     func setscrollOffset(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / bounds.width
        pageControl.currentPage = Int(index.truncatingRemainder(dividingBy: CGFloat(picUrls.count)))
        delegate?.cycleScrollView?(self, didScrolledToItemIndex: Int(index) % picUrls.count )
    }
}


