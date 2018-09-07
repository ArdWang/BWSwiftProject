//
//  DeviceCell.swift
//  BWSwiftProject
//
//  Created by rnd on 2018/7/9.
//  Copyright © 2018年 Radiance Instruments Ltd. All rights reserved.
//

import UIKit
import SnapKit

class DeviceCell: UITableViewCell {
    
    var txtLabel: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        txtLabel = UILabel()
        txtLabel?.text = "我日你妈"
        txtLabel?.textColor = UIColor.gray
        self.addSubview(txtLabel!)
        
        txtLabel?.snp.makeConstraints{(make)-> Void in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(10)
            make.height.equalTo(50)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
