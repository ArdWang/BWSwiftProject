//
//  BaseTableViewController.swift
//  BWSwiftProject
//
//  Created by rnd on 2018/7/9.
//  Copyright © 2018年 Radiance Instruments Ltd. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func customContentView(){
        let navigationBar = UINavigationBar()
        var backgroundImage:UIImage? = nil
        var textAttributes:NSDictionary? = nil
        //设置文字颜色和背景颜色
        navigationBar.barTintColor = UIColor.blue
        //navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor, UIColor.white]
        //self.navigationController?.navigationBar.titleTextAttributes =
           //[NSForegroundColorAttributeName: UIColor.white]
        
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


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
