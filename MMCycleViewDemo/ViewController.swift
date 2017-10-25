//
//  ViewController.swift
//  MMCycleViewDemo
//
//  Created by Mr.Wang on 2017/10/24.
//  Copyright © 2017年 Project. All rights reserved.
//
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
import UIKit
import Alamofire

class ViewController: UIViewController,MMCycleDelegate {
    func cycleSelectIndex(_ cycleView: MMCycleView, selectIndex: NSInteger) {
        print(selectIndex)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCycleViewOne()
        self.createCycleViewTwo()
    }

    func createCycleViewOne() -> Void {
        let imgArr:Array = [#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "4")]
        let titleArray:Array = ["今天是10.24程序员节日","可是他们说月薪低于三万的只能是码农","那如果是这样的话，我只能是一个码农","我靠，我不服。。。"]
        let dataArr:NSMutableArray = NSMutableArray.init()
        for index in 0...3 {
            let model:MMCycleModel = MMCycleModel.model(title: titleArray[index], image: imgArr[index], image_url: String())
            dataArr.add(model)
        }

        let frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:200)
        let cycleView:MMCycleView = MMCycleView.init(frame: frame)
        cycleView.delegate = self
        cycleView.sourceModelArray = dataArr as! Array<MMCycleModel>
        cycleView.pageControlAlignment = .right
        cycleView.titleLabelAlignment = .left
        cycleView.pageIndicatorTintColor = UIColor.red
        cycleView.currentPageIndicatorTintColor = UIColor.green
        cycleView.cycleTime = 5
        self.view.addSubview(cycleView)
    }

    func createCycleViewTwo() -> Void {
        let frame = CGRect(x:0,y:220,width:SCREEN_WIDTH,height:200)
        let cycleView:MMCycleView = MMCycleView.init(frame: frame)
        cycleView.delegate = self
        cycleView.pageControlAlignment = .center
        cycleView.titleHiden = false
        cycleView.placeHolderImage = #imageLiteral(resourceName: "1")
        self.view.addSubview(cycleView)
        
        let imgUrl_1 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508906556857&di=059b56e3db2df5f27dda25123ab704c9&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2F0132bdefeb6ed1a5a611793c87098fa52cbb2f9b.jpg"
        
        let imgUrl_2 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508906556857&di=2b9d94686225883f36ff2e3bb07fc166&imgtype=0&src=http%3A%2F%2Fstatic01.coloros.com%2Fbbs%2Fdata%2Fattachment%2Fforum%2F201408%2F19%2F155846f4rtpzb9c0scclbg.jpg"
        
        let imgUrl_3 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508906556857&di=6576c8cf764c84a2c1389366d0620b60&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F57%2F63%2F10R58PIC5KI_1024.jpg"
        
        let imgUrl_4 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508906556857&di=b3a325bf9c17aff66f37b53445e7d062&imgtype=0&src=http%3A%2F%2Fupload-images.jianshu.io%2Fupload_images%2F7284979-60bc93e0dba4199b.jpeg%3FimageMogr2%2Fauto-orient%2Fstrip%257CimageView2%2F2%2Fw%2F1080%2Fq%2F50"
        
        
        let model1:MMCycleModel = MMCycleModel.model(title: String(), image: UIImage(), image_url: imgUrl_1)
        let model2:MMCycleModel = MMCycleModel.model(title: String(), image: UIImage(), image_url: imgUrl_2)
        let model3:MMCycleModel = MMCycleModel.model(title: String(), image: UIImage(), image_url: imgUrl_3)
        let model4:MMCycleModel = MMCycleModel.model(title: String(), image: UIImage(), image_url: imgUrl_4)
        cycleView.sourceModelArray = [model1,model2,model3,model4]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

