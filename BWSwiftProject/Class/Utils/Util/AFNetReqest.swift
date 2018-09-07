//
//  AFNetReqest.swift
//  BWSwiftProject
//
//  Created by rnd on 2018/7/10.
//  Copyright © 2018年 Radiance Instruments Ltd. All rights reserved.
//

import UIKit
import Alamofire

//创建枚举get和post请求
enum MethodType {
    case get
    case post
}

private let ShareInstance = AFNetReqest()

class AFNetReqest {
    class var sharedInstance : AFNetReqest {
        return ShareInstance
    }
}

extension AFNetReqest{
    
    /*
        返回JSON数据
     */
    func requestJSON(_ type:MethodType,urlString:String,parameters:[String:Any],finishedCallback:@escaping (_ result : Any) -> ()) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]

        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(urlString, method: method, parameters: parameters,headers:headers).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
    
    /*
        返回Data数据
     */
    func requestData(_ type:MethodType,urlString:String,parameters:[String:Any],success:@escaping (_ response : Data)->(),fail:@escaping (_ error : Error) -> ()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(urlString, method: method, parameters: parameters).responseData { (response) in
            switch response.result{
                case .success(let data):
                    success(data)
                case .failure(let error):
                    fail(error)
                }
        }
    }
    
}
