//
//  CycleCell.swift
//  ProjectOneSwfit
//
//  Created by Mr.Wang on 2017/10/18.
//  Copyright © 2017年 AprilDay. All rights reserved.
//



import UIKit
class MMCycleCell: UICollectionViewCell {
    public lazy var indexLabel:UILabel = {
        let label:UILabel = UILabel.init(frame: CGRect(x:0,y:self.mm_height * 0.85,width:self.mm_width,height:self.mm_height * 0.15))
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    

    public lazy var imgV:UIImageView = {
        let imageV = UIImageView.init(frame: self.bounds)
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imgV)
        self.addSubview(self.indexLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
