//
//  PersistTools.swift
//  MySecond
//
//  Created by lixs on 2016/12/2.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation

class PersistTools {
    
    let userDefault = UserDefaults.standard
    
    func setString(key:String,value:String) {
        userDefault.set(value, forKey: key)
    }
    
    func getString(key:String) -> String {
        let value = userDefault.string(forKey: key)
        if(value == nil){
            return "";
        }
        return value!;
    }
    
}
