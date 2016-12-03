//
//  BikeInfo.swift
//  MySecond
//
//  Created by lixs on 2016/12/1.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation
import HandyJSON

class BikeInfo : HandyJSON{
    /**
     {"bike_num":"221634",
     "bike_pwd":"7281",
     "contributoryId":"977a14ba4a",
     "createdAt":"2016-11-16 08:53:52",
     "objectId":"5c297ae91e",
     "updatedAt":"2016-11-16 08:53:52"}
     */
    
    var bike_num: String?
    var createdAt: String?
    var updatedAt: String?
    var contributoryId: String?
    var bike_pwd: String?
    var objectId: String?
    required init(){}
}
