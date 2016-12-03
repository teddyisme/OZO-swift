//
//  UserUtils.swift
//  MySecond
//
//  Created by lixs on 2016/12/2.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation
class UserUtils{
    var persistTool = PersistTools();
    let userIdTag = "USERID"
    
    func setUserId(userid:String) -> Void {
        persistTool.setString(key: userIdTag, value: userid)
    }
    
    func getUserId() -> String {
        return persistTool.getString(key: userIdTag)
    }
    
}
