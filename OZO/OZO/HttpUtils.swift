//
//  HttpUtils.swift
//  MySecond
//
//  Created by 栗新生 on 2016/12/2.
//  Copyright © 2016年 栗新生. All rights reserved.
//

import Foundation
import Alamofire

struct JSONStringArrayEncoding: ParameterEncoding {
    private let array: [String]
    
    init(array: [String]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest.urlRequest
        
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        
        urlRequest?.httpBody = data
        
        return urlRequest!
    }
}
