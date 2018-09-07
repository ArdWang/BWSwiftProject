//
//  BaseViewController.swift
//  BWSwiftProject
//
//  Created by rnd on 2018/7/9.
//  Copyright © 2018年 Radiance Instruments Ltd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func customContentView(){
        let navigationBar = UINavigationBar()
        var backgroundImage:UIImage? = nil
        var textAttributes:NSDictionary? = nil
        //设置文字颜色和背景颜色
        navigationBar.barTintColor = UIColor.blue
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }
    
    //左边
    func customNavigationLeftItem(){
        
    }
    
    //右边
    func customNavigationRightItem(){
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
