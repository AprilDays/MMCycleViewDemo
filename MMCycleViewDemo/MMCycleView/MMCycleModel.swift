//
//  CycleModel.swift
//  MMCycleViewDemo
//
//  Created by Mr.Wang on 2017/10/24.
//  Copyright © 2017年 Project. All rights reserved.
//

import UIKit

class MMCycleModel: NSObject {
    var title:String?
    var image:UIImage?
    var image_url:String?
    
    class func model(title:String,image:UIImage,image_url:String) -> MMCycleModel {
        let model:MMCycleModel = MMCycleModel.init()
        model.title = title
        model.image = image
        model.image_url = image_url
        return model
    }
    

}
