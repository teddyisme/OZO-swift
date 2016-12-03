//
//  constant.swift
//  MySecond
//
//  Created by lixs on 2016/11/30.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation
import Alamofire

let bmobkey = "09d8a6a6235b356327d62d450435004c"
let apiKey = "8fb5645bdf9c6b0a886da2e6ea86ceec"
let headers: HTTPHeaders = [
    "Content-Type" : "application/json",
    "X-Bmob-Application-Id" : bmobkey,
    "X-Bmob-REST-API-Key" : apiKey
]

//获取邀请码
let getRegisterNum = "https://api.bmob.cn/1/classes/RegisterNum"
//根据车牌获取车信息
let getBikePwd = "https://api.bmob.cn/1/classes/bikes"
//登录
let login = "https://api.bmob.cn/1/login"
//注册
let register = "https://api.bmob.cn/1/users"
//添加自行车
let addBike = "https://api.bmob.cn/1/classes/bikes"
