//
//  MyColor.swift
//  MySecond
//
//  Created by lixs on 2016/11/29.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation
import UIKit

/// 根据RGBA生成颜色(格式为：22,22,22,0.5)
var gof_RGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
}

/// 根据RGB生成颜色(格式为：22,22,22)
var gof_RGBColor: (CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1);
}

/// 根据色值生成颜色(无透明度)(格式为#ffffff)
func gof_ColorWithHex(hexColor: String) -> UIColor {
    // 存储转换后的数值
    var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
    // 计算前缀数量
    var prefixCount = 0
    
    if hexColor.hasPrefix("0x") || hexColor.hasPrefix("0X") {
        prefixCount = 2 // 前缀有两位
    }
    if hexColor.hasPrefix("#") {
        prefixCount = 1 // 前缀有一位
    }
    // 分别转换进行转换
    Scanner(string: hexColor[(0+prefixCount)..<(2+prefixCount)]).scanHexInt32(&red)
    
    Scanner(string: hexColor[(2+prefixCount)..<(4+prefixCount)]).scanHexInt32(&green)
    
    Scanner(string: hexColor[(4+prefixCount)..<(6+prefixCount)]).scanHexInt32(&blue)
    
    
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
}

extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return self[startIndex..<endIndex]
        }
    }
}

/// 黑色
let kBColor = gof_ColorWithHex(hexColor: "#000000");
/// 白色
let kWColor = gof_ColorWithHex(hexColor: "#ffffff")
///橘色
let kOColor = gof_ColorWithHex(hexColor: "#cf703c")
///黄色
let kYColor = gof_ColorWithHex(hexColor: "#fdbd4d")
/// 无色
let kCColor = UIColor.clear;
///深色主题
let KBackGroundColor = gof_ColorWithHex(hexColor: "#363535")
///半透明弹框背景 172,169,169
let KTranslateBackGround = gof_RGBAColor(169,169,169,0.6)
