//
//  CustomImgList.swift
//  CustomImgListSwift
//
//  Created by lihualin on 15/6/15.
//  Copyright (c) 2015年 lihualin. All rights reserved.
//

import UIKit

class CustomImgList: UIView {
    let imgViewWidth = UIScreen.mainScreen().bounds.width
    let imgViewHeight = UIScreen.mainScreen().bounds.height
    var imagesList:NSArray!
    var defalutRect:CGRect!
    var titlelabel:UILabel!

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
    }
    //初始化view
    func createSelf(frame: CGRect , imgs: NSArray){
        self.frame = frame
        self.backgroundColor = UIColor.clearColor()
        imagesList = imgs
        defalutRect = frame
        self.createImagesView(imagesList)

    }
    //创建图片视图
    func createImagesView(imgs: NSArray){
        
        for (var i = 0; i < imgs.count; i++){
            let imgstr = imgs.objectAtIndex(i) as NSString
            var imageView = UIImageView(image: UIImage(named: imgstr))
            let height = defalutRect.size.height as CGFloat
            imageView.frame = CGRectMake(CGFloat(i)*(height+10),0 ,height, height)
            imageView.userInteractionEnabled = true;
            imageView.backgroundColor = UIColor.clearColor()
            imageView.tag = 10+i
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
           let tap = UITapGestureRecognizer(target:self, action: Selector("enlargeImg:")) as UITapGestureRecognizer
            imageView.addGestureRecognizer(tap)
            self.addSubview(imageView)
        }
    }
    
    
    //点击放大
    func enlargeImg(tap:UITapGestureRecognizer){
       self.frame = CGRectMake(0, 0, imgViewWidth, imgViewHeight)
       self.backgroundColor = UIColor.blackColor()
        let selectedImgView = tap.view as UIImageView
    
        //显示数字
        titlelabel = UILabel(frame: CGRectMake(0, 20, imgViewWidth, 20))
        titlelabel.backgroundColor = UIColor.clearColor()
        titlelabel.text = String(selectedImgView.tag-10+1)+"/"+String(imagesList.count)
        titlelabel.textColor = UIColor.whiteColor()
        titlelabel.textAlignment = NSTextAlignment.Center
        self.addSubview(titlelabel)
        
        for (var i = 0 ; i < imagesList.count ;i++ ){
           var imgView = self.viewWithTag(10+i) as UIImageView
            imgView.frame = CGRectMake(CGFloat(10+i-selectedImgView.tag)*imgViewWidth, (titlelabel.frame.origin.y+titlelabel.frame.size.height+10), imgViewWidth, imgViewHeight)
            imgView.contentMode = UIViewContentMode.ScaleAspectFit
            imgView.clipsToBounds = false
           
           let tapdown = UITapGestureRecognizer(target: self, action: Selector("reductionSmallImg:"))
            imgView.addGestureRecognizer(tapdown)
            
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("swipeAction:"))
            swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
            imgView.addGestureRecognizer(swipeLeft)
            let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("swipeAction:"))
            swipeRight.direction = UISwipeGestureRecognizerDirection.Right
            imgView.addGestureRecognizer(swipeRight)
            
        }
        
    }
    
    //放大后左右滑动事件
    func swipeAction(swipe:UISwipeGestureRecognizer){
      let selectedImgView = swipe.view as UIImageView
        if swipe.direction == UISwipeGestureRecognizerDirection.Left {
            //左滑
            if selectedImgView.tag-10 == imagesList.count-1 {
                return
            }
            titlelabel.text = String(selectedImgView.tag-10+2)+"/"+String(imagesList.count)
            for (var i = 0 ; i < imagesList.count ;i++ ){
                var imgView = self.viewWithTag(10+i) as UIImageView
                imgView.frame = CGRectMake(imgView.frame.origin.x-imgViewWidth, imgView.frame.origin.y, imgViewWidth, imgViewHeight)
                
            }
        }else{
            //右滑
            if selectedImgView.tag-10 == 0 {
                return
            }
            titlelabel.text = String(selectedImgView.tag-10)+"/"+String(imagesList.count)
            for (var i = 0 ; i < imagesList.count ;i++ ){
                var imgView = self.viewWithTag(10+i) as UIImageView
                 imgView.frame = CGRectMake(imgView.frame.origin.x+imgViewWidth, imgView.frame.origin.y, imgViewWidth, imgViewHeight)
                
            }
        }
        
    }
    
    //还原图片
    func reductionSmallImg(tap:UITapGestureRecognizer){
        self.frame = defalutRect
        self.backgroundColor = UIColor.clearColor()
        titlelabel.removeFromSuperview()
        titlelabel = nil
        for (var i = 0 ; i < imagesList.count ;i++ ){
            var imgView = self.viewWithTag(10+i) as UIImageView
            let height = defalutRect.size.height as CGFloat
            imgView.frame = CGRectMake(CGFloat(i)*(height+10),0 ,height, height)
            imgView.contentMode = UIViewContentMode.ScaleAspectFill
            imgView.clipsToBounds = true
            
            var tap = UITapGestureRecognizer(target: self, action: Selector("enlargeImg:")) as UITapGestureRecognizer
            imgView.addGestureRecognizer(tap)
            
        }

    }
}
