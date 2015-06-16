//
//  ViewController.swift
//  CustomImgListSwift
//
//  Created by lihualin on 15/6/15.
//  Copyright (c) 2015年 lihualin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var imgs:NSArray!
    var custom:CustomImgList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        imgs = ["0.jpg","1.jpg","10.jpg","15.jpg"]
        custom = CustomImgList() as CustomImgList
      
        custom?.createSelf(CGRectMake(40,200 ,240, 50),imgs:imgs)
        self.view.addSubview(custom!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

