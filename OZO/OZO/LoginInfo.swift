//
//  LoginInfo.swift
//  MySecond
//
//  Created by lixs on 2016/12/2.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation
import HandyJSON

class LoginInfo : HandyJSON{
    /**{
     "createdAt": "2016-11-13 00:16:47",
     "mobilePhoneNumber": "13671629914",
     "objectId": "",
     "sessionToken": "",
     "updatedAt": "2016-11-13 00:16:47",
     "username": ""
     }
     */
     var createdAt: String?
    var mobilePhoneNumber: String?
    var objectId: String?
    var sessionToken: String?
    var updatedAt: String?
    var username: String?
    
    required init(){}

}
