//
//  BlueUtil.swift
//  BWSwiftProject
//
//  Created by rnd on 2018/7/9.
//  Copyright © 2018年 Radiance Instruments Ltd. All rights reserved.
//  蓝牙的工具类型
//

import UIKit
import CoreBluetooth

class BlueUtil: NSObject,CBCentralManagerDelegate, CBPeripheralDelegate {
    
    private let BW_PROJECT_TEMP:String = "783F2991-23E0-4BDC-AC16-78601BD84B39"
   
    //可以为空
    private var centralManager: CBCentralManager?
    private var peripheral: CBPeripheral?
    private var characteristic: CBCharacteristic?
    private var deviceList:NSMutableArray?
    
    private var peripheralList:NSMutableArray?
    
    private var readtempcharater:CBCharacteristic?
    
    
    
    //单列模式
    static let shared = BlueUtil()
    
    
    
    private override init() {
        super.init()
        centralManager = CBCentralManager.init(delegate:self, queue:.main)
        self.deviceList=getDeviceList()
        self.peripheralList = getPeripheralList()
    }
    
    func getDeviceList() -> NSMutableArray {
        if(deviceList==nil){
            deviceList = NSMutableArray()
        }
        return deviceList!;
    }
    
    func getPeripheralList() -> NSMutableArray {
        if(peripheralList==nil){
            peripheralList = NSMutableArray()
        }
        return peripheralList!;
    }
    
    
    // 判断手机蓝牙状态
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("未知的")
        case .resetting:
            print("重置中")
        case .unsupported:
            print("不支持")
        case .unauthorized:
            print("未验证")
        case .poweredOff:
            print("未启动")
        case .poweredOn:
            print("可用")
            startScan()
        }
    }
    
    /*
        开始扫描
     */
    func startScan() {
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    /*
        停止扫描
     */
    func stopScan() {
        centralManager?.stopScan()
    }
    
    /*
        得到设备列表
     */
    func getDeviceLists() -> NSMutableArray {
        return self.deviceList!;
    }
    
    /*
        连接蓝牙
     */
    func connectBlue(row:Int)  {
        centralManager?.connect(peripheralList![row] as! CBPeripheral, options: nil)
    }
    
    
    /*
        查询外设
     */
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if(!((self.deviceList?.contains(peripheral))!)){
            self.deviceList?.add(peripheral)
            self.peripheralList?.add(peripheral)
        }
        
        //self.peripheral = peripheral
        // 根据外设名称来过滤
        //        if (peripheral.name?.hasPrefix("WH"))! {
        //            central.connect(peripheral, options: nil)
        //        }
        //central.connect(peripheral, options: nil)
    }
    
    /*
        4. 连接外设---将来需要选中tableViewCell的某一行, 来连接外设
        用下面的方法connectPeripheral 模拟tableViewCell选中的方法
     */
    
    func connect(peripheral:CBPeripheral){
        centralManager?.connect(peripheral, options: nil)
    }
    
    /*
        5. 当连接到外围设备时调用的代理方法
     */
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //停止扫描
        centralManager?.stopScan()
        //5.1 设置外设的代理
        peripheral.delegate = self;
        //5.2 用外设来扫描服务（传如UUID数组NSArray<CBUUID *> *)serviceUUIDs） 如果不传, 代表扫描所有服务
        peripheral.discoverServices(nil)
    }
    
    /*
        6. 当扫描到服务的时候, 此代理方法会调用
     */
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        //找到指定服务UUID, 然后去扫描此服务的特性
        //services: 当扫描到服务时, 所有的服务会存在在外设的services属性中
        for service:CBService in peripheral.services!{
            //将来服务和特征的UUID, 都在蓝牙厂商提供的文档中
            //扫描此服务的特性
            //Characteristics: 特征
            //如果特征传nil, 代表扫描所有特征
            peripheral.discoverCharacteristics(nil, for: service)
            
        }
    }
    
    /*
        7. 扫描到某个服务的某个特征时, 会调用的代理方法
     */
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        //找到指定特征的UUID, 然后就可以做数据交互了
        //characteristics: 当扫描到特征时, 所有的特征会存在在服务的characteristics属性中
        for characteristic:CBCharacteristic in service.characteristics!{
            // 假设特征的UUID为 654321
            if characteristic.uuid.uuidString==BW_PROJECT_TEMP{
                readtempcharater = characteristic;
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    ///获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if(characteristic==readtempcharater){
            let temps:String = getTempData(characteristic: characteristic)
            print("\(temps)")
        }
    }
    
    //向特征中写入数据后调用
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    

    //蓝牙链接失败时调用
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Bluetooth Conncet Fail")
        let disConnect:String = "disConnect"
        NotificationCenter.default.post(name: Notification.Name(rawValue: disConnect), object: self,userInfo:["value":"disConnect"])
    }
    
    //蓝牙断开链接时调用
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Bluetooth Conncet Fail")
        let disConnect:String = "disConnect"
        NotificationCenter.default.post(name: Notification.Name(rawValue: disConnect), object: self,userInfo:["value":"disConnect"])
    }
    
    //写入数据
    func writeValue(_ serviceUUID: String, characteristicUUID: String, peripheral: CBPeripheral!, data: NSData!){
        //peripheral.writeValue(data as Data, forCharacteristic: self.writeCharacteristic, type: CBCharacteristicWriteType.WithResponse)
        print("手机向蓝牙发送的数据为:\(data)")
    }
    
    /*
        解析温度数据
     */
    func getTempData(characteristic:CBCharacteristic) -> String {
        let data:Data = characteristic.value!
        return String(data:data,encoding:String.Encoding.utf8)!
    }
    
    /*
        解析OTA的数据
     */
    func getOtaData(characteristic:CBCharacteristic)->String{
        let data:Data = characteristic.value!
        return convertDatatoHexStr(data: data)!
    }
    
   
    func convertDatatoHexStr(data: Data?) -> String? {
        if data == nil || (data?.count ?? 0) == 0 {
            return ""
        }
        var string = String(repeating: "\0", count: data?.count ?? 0)
        data?.enumerateBytes({ bytes, byteRange, stop in
            let dataBytes = UInt8(bytes ?? 0) as? [UInt8]
            for i in 0..<Int(byteRange.length) {
                let hexStr = String(format: "%x", &0xff as? dataBytes)
                if hexStr.count == 2 {
                    string += hexStr
                } else {
                    string += "0\(hexStr)"
                }
            }
        })
        return string
    }
    
   

}
