//
//  WfModel.swift
//  BWSwiftProject
//
//  Created by rnd on 2018/7/9.
//  Copyright © 2018年 Radiance Instruments Ltd. All rights reserved.
//

import UIKit
import Alamofire

protocol WfModeldDelegate:NSObjectProtocol{
    func getSuccess()
}


class WfModel:NSObject{
    weak var delegate:WfModeldDelegate?
    
    /*
        获取设备
     */
    func getDevice() {
        let baseUrl:String = "http://www.riltemp.club:8080/BwProject/"
        let strUrl:String = baseUrl+"device/getDevice"
        
        //第一种方式
        /*Alamofire.request(strUrl,method:.post,parameters:nil).validate()
            .responseData{response in
                switch response.result {
                case .success(let data):
                    print("\(data)")
                    do {
                        let xiaoming = try JSONDecoder().decode(Device.self, from: data)
                        print("\(xiaoming.devices)")
                    } catch {
                        // 异常处理
                    }
                    break
                case .failure(let error):
                    print("\(error)")
                    break
                }
        }*/
        
        let params:[String:Any] = ["username":"111"]
        
        //第二种方式
        AFNetReqest.sharedInstance.requestData(.post,urlString: strUrl,parameters: params,success:{(json)->Void in
            do {
                let xiaoming = try JSONDecoder().decode(Device.self, from: json)
                print("\(xiaoming.devices)")
            } catch {
                // 异常处理
            }
        },fail: {(error) -> Void in
            print(error)
        })
        
        
        //第三种方法
        
        
    }
   
}


