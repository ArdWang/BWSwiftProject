//
//  WfController.swift
//  BWSwiftProject
//
//  Created by rnd on 2018/7/9.
//  Copyright © 2018年 Radiance Instruments Ltd. All rights reserved.
//

import UIKit

class WfController: UIViewController,WfModeldDelegate {
   
    var wfModel:WfModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initData()
    }
    
    func initData(){
        wfModel = WfModel()
        wfModel.delegate = self;
        wfModel.getDevice()
    }
    
    func getSuccess() {
        print("ok success")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
