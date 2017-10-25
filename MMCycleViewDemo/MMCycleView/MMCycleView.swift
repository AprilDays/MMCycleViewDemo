//
//  MMCycleView.swift
//  ProjectOneSwfit
//
//  Created by Mr.Wang on 2017/10/17.
//  Copyright © 2017年 AprilDay. All rights reserved.
//

let timerTime = 2.5



public enum PageControlAlignment : Int {
    case left = 0
    case center
    case right
}

import UIKit
import AlamofireImage

@objc protocol MMCycleDelegate {
//    @objc optional
    func cycleSelectIndex(_ cycleView:MMCycleView,selectIndex:NSInteger)
}

class MMCycleView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
    //代理
    weak var delegate:MMCycleDelegate?
    // 数据
    var sourceModelArray:Array<MMCycleModel> = Array.init() {
        didSet {
            if sourceModelArray.count <= 1 {
                self.itemsModelArray.addObjects(from: sourceModelArray)
            } else {
                let objF:MMCycleModel = sourceModelArray.first!
                let objL:MMCycleModel = sourceModelArray.last!
                self.itemsModelArray.add(objL)
                self.itemsModelArray.addObjects(from: sourceModelArray)
                self.itemsModelArray.add(objF)
            }
            self.setItemsArray(sourceCount: sourceModelArray.count)
        }
    }
    
    //设置pageControl位置
    var pageControlAlignment:PageControlAlignment {
        didSet{
            self.setPageControlAlignmen()
        }
    }
    
    //设置titleLabel位置
    var titleLabelAlignment:NSTextAlignment {
        didSet {
            self.cycleCollectionView.reloadData()
        }
    }
    //设置titleLabel是否显示
    var titleHiden:Bool{
        didSet {
            self.cycleCollectionView.reloadData()
        }
    }
    // 设置pageControl的圆点颜色
    var pageIndicatorTintColor:UIColor = UIColor.white {
        didSet {
           self.pageControll.pageIndicatorTintColor = pageIndicatorTintColor
        }
    }
    // 设置pageControl的选中圆点颜色
    var currentPageIndicatorTintColor:UIColor = UIColor.black {
        didSet {
            self.pageControll.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        }
    }
    // timer的时间间隔
    var cycleTime: TimeInterval = 5 {
        didSet {
            if self.sourceModelArray.count == 0 {
                return
            }
            self.timer.invalidate()
            if #available(iOS 10.0, *) {
                self.timer = Timer.scheduledTimer(withTimeInterval: self.cycleTime, repeats: true, block: { (timer) in
                    self.setPage()
                })
            } else {
                self.timer = Timer.scheduledTimer(timeInterval: self.cycleTime, target: self, selector: #selector(setPage), userInfo: nil, repeats: true)
            }
            let loop:RunLoop = RunLoop.current
            loop.add(self.timer, forMode: RunLoopMode.commonModes)
            self.timer.fire()
        }
    }
    //占位图
    var placeHolderImage:UIImage = UIImage.init()
    
    
    
    
    private let ID = "Cell";
    private var isDargin:Bool = false
    private var X:CGFloat = 10
    private lazy var timer:Timer = {
        var timer:Timer?
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: self.cycleTime, repeats: true, block: { (timer) in
                self.setPage()
            })
        } else {
            timer = Timer.scheduledTimer(timeInterval: self.cycleTime, target: self, selector: #selector(setPage), userInfo: nil, repeats: true)
        }
        let loop:RunLoop = RunLoop.current
        loop.add(timer!, forMode: RunLoopMode.commonModes)
        return timer!
    }()
    
    private lazy var pageControll:MMPageControl = {
        let rect = CGRect(x:0,y:self.mm_height * 0.85,width:self.mm_width,height:self.mm_height * 0.15)
        let page:MMPageControl = MMPageControl.init(frame: rect)
        return page;
    }()
    private lazy var itemsModelArray:NSMutableArray = {
        let array = NSMutableArray.init()
        return array
    }()

    

    
    //MARK:----LazyLaoding
    private lazy var cycleCollectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSize(width:SCREEN_WIDTH,height:200)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let collectionV = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.isPagingEnabled = true
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.backgroundColor = self.backgroundColor
        collectionV.register(MMCycleCell.self, forCellWithReuseIdentifier: ID)
        return collectionV
    }()
    
    override init(frame: CGRect) {
        self.pageControlAlignment = .center
        self.titleLabelAlignment = .left
        self.titleHiden = false
        super.init(frame: frame)
        self.addSubview(self.cycleCollectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MMCycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! MMCycleCell
        let model:MMCycleModel = self.itemsModelArray[indexPath.row] as! MMCycleModel
        cell.indexLabel.textAlignment = self.titleLabelAlignment
        cell.indexLabel.isHidden = self.titleHiden
        cell.indexLabel.text = model.title
        if (model.image_url != nil && model.image_url != "") {
            cell.imgV.image = self.placeHolderImage
            cell.imgV.af_setImage(withURL: NSURL.init(string: model.image_url!)! as URL)
        } else if (model.image != nil) {
            cell.imgV.image = model.image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.cycleSelectIndex(self, selectIndex: indexPath.row-1)
    }
    //MARK:UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= CGFloat(self.itemsModelArray.count-1) * SCREEN_WIDTH {
            scrollView.contentOffset = CGPoint(x:SCREEN_WIDTH,y:0)
        }
        if scrollView.contentOffset.x <= 0 {
            scrollView.contentOffset = CGPoint(x:SCREEN_WIDTH * CGFloat(self.itemsModelArray.count-2),y:0)
        }
        self.pageControll.currentPage = Int(scrollView.contentOffset.x / SCREEN_WIDTH) - 1
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.timer.fireDate = NSDate.distantPast
        self.isDargin = true
    }
    
    func setPageControlAlignmen() -> Void {
            switch pageControlAlignment {
            case .left:
                self.X = 10
                break
            case .center:
                self.X = SCREEN_WIDTH/2 - self.pageControll.mm_width/2
                break
            case .right:
                self.X = SCREEN_WIDTH - self.pageControll.mm_width - 10
                break
            }
            self.pageControll.mm_x = self.X;
    }
    
    @objc func setPage() {
        if isDargin {
            self.isDargin = false
            return
        }
        let index = self.cycleCollectionView.contentOffset.x/SCREEN_WIDTH
        let cellIndexPath = IndexPath.init(row: Int(index) + 1, section: 0)
        self.cycleCollectionView.scrollToItem(at: cellIndexPath, at: .right, animated: true)
    }
    
    deinit {
        self.timer.invalidate()
    }
    
    func setItemsArray(sourceCount:NSInteger) -> Void {
            self.cycleCollectionView.reloadData()
            self.pageControll.removeFromSuperview()
            self.pageControll.numberOfPages = sourceCount
            self.pageControll.currentPage = 0
            self.pageControll.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor
            self.pageControll.pageIndicatorTintColor = self.pageIndicatorTintColor
            self.pageControll.isEnabled = false
            self.pageControll.sizeToFit()
            self.addSubview(self.pageControll)
            self.timer.fire()
            self.setPageControlAlignmen()
    }
    
    
}
