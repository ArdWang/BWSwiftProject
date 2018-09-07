//
//  WfBean.swift
//  BWSwiftProject
//
//  Created by rnd on 2018/7/9.
//  Copyright © 2018年 Radiance Instruments Ltd. All rights reserved.
//

import UIKit


    struct Device:Codable {
        var code:String
        var message:String
        var devices:[DeviceData]
        
        struct DeviceData:Codable {
            var deviceaddre:String
            var tempunit:String
            var wifistrength:String
            var battstatus:String
            var fanconnect:String
            var createtime:Int
            var updatetime:Int
        }
    }
    

    

