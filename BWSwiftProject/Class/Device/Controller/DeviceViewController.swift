//
//  DeviceViewController.swift
//  BWSwiftProject
//
//  Created by rnd on 2018/7/9.
//  Copyright © 2018年 Radiance Instruments Ltd. All rights reserved.
//

import UIKit
import CoreBluetooth


class DeviceViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource{
    
    private var deviceList:NSMutableArray?
    
    private let blueUtil = BlueUtil.shared
    
    //定时器
    private var devTimer=Timer()
    
    var tableView:UITableView!
    
    var peripheral: CBPeripheral?
    
    //let arry:[String] = ["我是谁", "我从哪里来", "要到哪里去"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let rect = self.view.frame
        tableView = UITableView(frame: rect)
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        initData()
    }
    
    func initData(){
        deviceList=getDeviceList()
        //tableView.reloadData()
        //deviceList = arry;
        devTimer = Timer.scheduledTimer(timeInterval:3, target: self, selector:#selector(getDeviceData),userInfo:nil,repeats: false)
        
    }
    
    func getDeviceList() -> NSMutableArray {
        if(deviceList==nil){
            deviceList = NSMutableArray()
        }
        return deviceList!;
    }
    
    /*
        获取设备数据
     */
    @objc func getDeviceData() {
        if(BlueUtil.shared.getDeviceLists().count>0){
            deviceList = BlueUtil.shared.getDeviceLists()
            tableView.reloadData()
        }
    }
    
    /*
        代理
     */
    func tableView(_tableView:UITableView, heightForHeaderInSection section:Int) ->CGFloat{
      return 100
    }
    
    func numberOfSections(in tableView: UITableView) ->Int {
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "DeviceCell"
        var cell:DeviceCell! = tableView.dequeueReusableCell(withIdentifier: indentifier)as?DeviceCell
        if cell == nil {
            cell = DeviceCell(style: .default, reuseIdentifier: indentifier)
        }
        
        if((deviceList?.count)!>0){
            peripheral = deviceList?[indexPath.row] as? CBPeripheral;
            cell.txtLabel?.text = peripheral?.name;
        }
        
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indentifier = "DeviceCell"
        var cell:DeviceCell! = tableView.dequeueReusableCell(withIdentifier: indentifier)as?DeviceCell
        if cell == nil {
            cell = DeviceCell(style: .default, reuseIdentifier: indentifier)
        }
        
        if((deviceList?.count)!>0){
            
            let alertController=UIAlertController(title: "Connect", message: "蓝牙连接", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction=UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler:{
                (alerts:UIAlertAction!)->Void in
                print("点击啦取消")
            })
            
            let okAction=UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler:{
                (alerts: UIAlertAction!) ->Void in
                //连接蓝牙
                BlueUtil.shared.connectBlue(row: indexPath.row)
            })
            
            alertController .addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController,animated: true,completion: nil)
        }
        
    }

   
}
