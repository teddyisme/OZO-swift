//
//  Result.swift
//  MySecond
//
//  Created by lixs on 2016/12/1.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation
import HandyJSON

class Results<T> : HandyJSON{
    var results:[T]?
    required init(){}
}
