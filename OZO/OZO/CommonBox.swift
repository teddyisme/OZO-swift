//
//  CommonBox.swift
//  MySecond
//
//  Created by 栗新生 on 2016/12/3.
//  Copyright © 2016年 栗新生. All rights reserved.
//

import Foundation
import UIKit

class CommonBox {
   
    var rootView = UIView();
    //自定义弹出框类型，目前仅针对项目支持两种
//    var type?;
    
    //弹出框背景
    let boxView = UIView();
    //弹出框父view
    let bView = UIView();
    
    init(rootView : UIView,type : Int) {
        self.rootView = rootView
        self.type = type;
    }
    
    func showBox() {
        addBoxBackView();
        if(type==1){
            addBoxFrame(height: 190);
        }else if(type==2){
            addBoxFrame(height: 210);
        }
        addBoxCloseBtn();
        //车牌输入框
//        addBikeNumEdite.backgroundColor=kYColor
//        addBikeNumEdite.placeholder="请输入车牌号"
//        addBikeNumEdite.minimumFontSize=14
//        addBikeNumEdite.textAlignment = .center
//        addBikeNumEdite.clearButtonMode = .whileEditing
//        addBikeNumEdite.keyboardType = .numberPad
//        addBikeNumEdite.isEnabled=true
//        addBikeNumEdite.text=nil
//        boxView.addSubview(addBikeNumEdite)
//        addBikeNumEdite.snp.makeConstraints { (make) in
//            make.centerX.equalTo(boxView)
//            make.height.equalTo(40)
//            make.top.equalTo(40)
//            make.left.equalTo(boxView).offset(30)
//            make.right.equalTo(boxView).offset(-30)
//        }
//        
//        
//        addBikePwdEdite.backgroundColor=kYColor
//        addBikePwdEdite.placeholder="请输入车密码"
//        addBikePwdEdite.minimumFontSize=14
//        addBikePwdEdite.textAlignment = .center
//        addBikePwdEdite.clearButtonMode = .whileEditing
//        addBikePwdEdite.keyboardType = .numberPad
//        addBikePwdEdite.isEnabled=true
//        addBikePwdEdite.text=nil
//        boxView.addSubview(addBikePwdEdite)
//        addBikePwdEdite.snp.makeConstraints { (make) in
//            make.centerX.equalTo(boxView)
//            make.height.equalTo(40)
//            make.top.equalTo(addBikeNumEdite.snp.bottom).offset(10)
//            make.left.equalTo(boxView).offset(30)
//            make.right.equalTo(boxView).offset(-30)
//        }
//        
//        //确定按钮
//        addBikeConfirmBtn.setTitle("添加车辆", for: .normal)
//        addBikeConfirmBtn.setTitleColor(kYColor, for: .normal)
//        addBikeConfirmBtn.isEnabled=true
//        addBikeConfirmBtn.addTarget(self, action:#selector(queryAction(_:)), for:.touchUpInside)
//        boxView.addSubview(addBikeConfirmBtn)
//        addBikeConfirmBtn.snp.makeConstraints { (make) in
//            make.width.equalTo(boxView)
//            make.height.equalTo(30)
//            make.centerX.equalTo(boxView)
//            make.top.equalTo(addBikePwdEdite.snp.bottom).offset(20)
//        }
        
    }
    
    
    
    
    
    
   private func addBoxBackView() {
        //背景蒙版
        bView.backgroundColor=KTranslateBackGround
        rootView.addSubview(bView)
        bView.snp.makeConstraints { (make) in
            make.edges.equalTo(rootView)
        }
        
    }
    
   private func addBoxFrame(height:Int) {
        //弹出框
        boxView.backgroundColor=KBackGroundColor;
        boxView.layer.cornerRadius=10
        bView.addSubview(boxView)
        boxView.snp.makeConstraints { (make) in
            make.center.equalTo(bView)
            make.height.equalTo(height)
            make.left.equalTo(bView).offset(30)
            make.right.equalTo(bView).offset(-30)
        }
    }
    
   private func addBoxCloseBtn() {
        //查询框关闭按钮
        let queryClose = UIButton();
        queryClose.setBackgroundImage(UIImage(named:"close"), for: .normal)
        queryClose.addTarget(self, action: #selector(closeBox(_:)), for: .touchUpInside)
        boxView.addSubview(queryClose)
        queryClose.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.width.height.equalTo(30)
            make.right.equalTo(boxView).offset(-26)
        }
    }
    
    @objc private func closeBox(_ button:UIButton) {
        rmoveChildrenViews(view:bView)
    }
    
   private func rmoveChildrenViews(view:UIView) {
        for v in view.subviews{
            v.removeFromSuperview()
            rmoveChildrenViews(view: v)
        }
        view.removeFromSuperview()
    }
    
    
}
