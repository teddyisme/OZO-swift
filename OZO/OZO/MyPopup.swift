//
//  MyPopup.swift
//  MySecond
//
//  Created by 栗新生 on 2016/11/30.
//  Copyright © 2016年 栗新生. All rights reserved.
//

import Foundation
import UIKit

class MyPopup: SwiftyPopup {
     init(frame: CGRect) {
        super.init(frame: frame)
        
        let close = UIButton(type: .Custom)
        close.setTitle("close", forState: .Normal)
        close.setTitleColor(UIColor.blueColor(), forState: .Normal)
        close.frame = CGRectMake(0, 185, 300, 30)
        close.addTarget(self, action: #selector(btnClose), forControlEvents: .TouchUpInside)
        contentView.addSubview(close)
        
        print(contentView.frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func btnClose() {
        dismiss()
    }
}
