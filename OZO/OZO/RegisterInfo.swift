//
//  RegisterInfo.swift
//  MySecond
//
//  Created by lixs on 2016/12/2.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation
import HandyJSON

class RegisterInfo : HandyJSON {
    /**
     "createdAt": "2016-11-16 09:10:52",
     "objectId": "",
     "sessionToken": ""
     */
    
    var createdAt: String?
    var objectId: String?
    var sessionToken: String?
    required init(){}

}
