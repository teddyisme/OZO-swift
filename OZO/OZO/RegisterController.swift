//
//  RegisterController.swift
//  MySecond
//
//  Created by lixs on 2016/12/2.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Alamofire
import HandyJSON
import Toast_Swift
class RegisterController: UIViewController {
    let topImage = UIImageView();
    let username = UITextField();
    let moblie = UITextField();
    let pwd = UITextField();
    let registerNum = UITextField();
    let toLogin = UIButton();
    let confirmBtn = UIButton();
    
    var register_num : String = "";
    
    override func viewDidLoad() {
        self.title="注册"
        self.view.backgroundColor=kWColor
        self.navigationItem.hidesBackButton = true
        
        addTopImage();
        addEdites();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //添加头部图片
    func addTopImage(){
        topImage.image=UIImage(named: "register_title")
        self.view.addSubview(topImage)
        topImage.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(60)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(80)
        }
        
    }
    //添加文本框
    func addEdites() {
        username.backgroundColor=kYColor
        username.placeholder="请输入您的姓名"
        username.textAlignment = .center
        username.clearButtonMode = .whileEditing
        self.view.addSubview(username)
        username.snp.makeConstraints { (make) in
            make.top.equalTo(topImage).offset(100)
            make.height.equalTo(44)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
        }
        
        moblie.backgroundColor=kYColor
        moblie.placeholder="请输入您的手机号"
        moblie.textAlignment = .center
        moblie.clearButtonMode = .whileEditing
        self.view.addSubview(moblie)
        moblie.snp.makeConstraints { (make) in
            make.top.equalTo(username.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.left.equalTo(username)
            make.right.equalTo(username)
        }
        
        pwd.backgroundColor=kYColor
        pwd.placeholder="请输入您的密码"
        pwd.textAlignment = .center
        pwd.clearButtonMode = .whileEditing
        pwd.isSecureTextEntry = true
        self.view.addSubview(pwd)
        pwd.snp.makeConstraints { (make) in
            make.top.equalTo(moblie.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.left.equalTo(username)
            make.right.equalTo(username)
        }
        
        registerNum.backgroundColor=kYColor
        registerNum.placeholder="请输入您的邀请码"
        registerNum.textAlignment = .center
        registerNum.clearButtonMode = .whileEditing
        self.view.addSubview(registerNum)
        registerNum.snp.makeConstraints { (make) in
            make.top.equalTo(pwd.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.left.equalTo(username)
            make.right.equalTo(username)
        }
        
        confirmBtn.backgroundColor=KBackGroundColor
        confirmBtn.setTitle("注册", for: .normal)
        confirmBtn.setTitleColor(kYColor, for: .normal)
        confirmBtn.addTarget(self, action:#selector(registerAction(_:)), for: .touchUpInside)
        self.view.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(registerNum.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.left.equalTo(pwd)
            make.right.equalTo(pwd)
        }
        
        toLogin.backgroundColor=UIColor.white
        toLogin.setTitleColor(KBackGroundColor, for: .normal)
        toLogin.titleLabel?.font=kAssistFont
        toLogin.setTitle("已有账号？去登录!", for: .normal)
        toLogin.addTarget(self, action:#selector(goLogin(_:)), for: .touchUpInside)
        self.view.addSubview(toLogin)
        toLogin.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(confirmBtn.snp.bottom).offset(10)
            make.left.equalTo(pwd)
            make.right.equalTo(pwd)
        }
        
    }
    
    func goLogin(_ button:UIButton)  {
        _=self.navigationController?.popViewController(animated: true)
    }
    
    //注册接口请求
    func registerAction(_ button:UIButton)  {
        
        if(((pwd.text)?.isEmpty)! || ((username.text)?.isEmpty)!
            || ((moblie.text)?.isEmpty)! || ((registerNum.text)?.isEmpty)!){
            self.view.makeToast("请填全信息!", duration: 1, position: ToastPosition.center)
            return
        }
        
        if(self.register_num.isEmpty){
            geRegisterNum();
            return;
        }
        
        if(self.register_num == (registerNum.text) ){
            zhuceNet();
        }
        
    }
    
    func zhuceNet() {
        let url = URL(string: register)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let parameters =  ["password":(pwd.text)!,"username":(username.text)!,"mobilePhoneNumber":(moblie.text)!]
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            // No-op
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(bmobkey, forHTTPHeaderField: "X-Bmob-Application-Id")
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-Bmob-REST-API-Key")
        
        Alamofire.request(urlRequest)
            .responseString { response in
                switch response.result {
                case .success(let value):
                    if let user = JSONDeserializer<RegisterInfo>.deserializeFrom(json: value) {
                        let userutil = UserUtils();
                        if  user.objectId != nil
                        {
                            userutil.setUserId(userid: user.objectId!)
                            self.navigationController?.pushViewController(MainController() , animated: true)
                        }else{
                            
                            self.view.makeToast("该手机号已经注册!", duration: 1, position: ToastPosition.center)
                        }
                        
                    }else{
                        self.view.makeToast("该手机号已经注册!", duration: 1, position: ToastPosition.center)
                    }
                case .failure(let error):
                    print("failure\(error)")
                }
        }
        
    }
    
    //获取邀请码
    func geRegisterNum() {
        Alamofire.request(getRegisterNum, headers: headers).responseString { response in
            switch response.result {
            case .success(let value):
                if let register = JSONDeserializer<Results<registNum>>.deserializeFrom(json: value) {
                    self.register_num = (register.results?[0].code)!
                    if(self.register_num == (self.registerNum.text) ){
                        self.zhuceNet();
                    }else{
                        self.view.makeToast("邀请码错误", duration: 1, position: ToastPosition.center)
                    }
                    
                }else{
                    self.view.makeToast("验证邀请码失败", duration: 1, position: ToastPosition.center)
                }
            case .failure(let error):
                print("failure\(error)")
            }
        }
    }
    
    
}
