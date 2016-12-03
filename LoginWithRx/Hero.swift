//
//  Hero.swift
//  LoginWithRx
//
//  Created by 田腾飞 on 2016/12/3.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit

class Hero: NSObject {
    var name: String
    var desc: String
    var icon: String
    
    init(name: String, desc: String, icon: String) {
        self.name = name
        self.desc = desc
        self.icon = icon
    }
}
