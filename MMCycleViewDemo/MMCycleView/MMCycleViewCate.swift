//
//  CycleView.swift
//  ProjectOneSwfit
//
//  Created by Mr.Wang on 2017/10/18.
//  Copyright © 2017年 AprilDay. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // x
    var mm_x:CGFloat {
        get {
            return frame.origin.x
        }
        
        set(newX) {
            var newFrame : CGRect = frame
            newFrame.origin.x     = newX
            frame                 = newFrame
        }
    }
    // y
    var mm_y:CGFloat {
        get {
            return frame.origin.y
        }
        set(newY) {
            var newFrame:CGRect = frame
            newFrame.origin.y = newY
            frame = newFrame
        }
    }
    
    // width
    var mm_width:CGFloat {
        get {
            return frame.size.width
        }
        set(newWidth) {
            var newFrame:CGRect = frame
            newFrame.size.width = newWidth
            frame = newFrame
        }
    }
    
    // height
    var mm_height:CGFloat {
        get {
            return frame.size.height
        }
        
        set(newHeight) {
            var newFrame = frame
            newFrame.size.height = newHeight
            frame = newFrame
        }
    }
}

