//
//  LoginController.swift
//  MySecond
//
//  Created by lixs on 2016/12/1.
//  Copyright © 2016年 lixs. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Alamofire
import HandyJSON
import Toast_Swift

class LoginController: UIViewController {
    let topImage = UIImageView();
    let username = UITextField();
    let pwd = UITextField();
    let confirmBtn = UIButton();
    let toRegisterBtn = UIButton();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 2.0)
        
        self.title = "登录"
        self.view.backgroundColor=UIColor.white
        
        addTopImage();
        
        addUIView();
    }
    
    //添加头部图片
    func addTopImage(){
        topImage.image=UIImage(named: "login_title")
        self.view.addSubview(topImage)
        topImage.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(60)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(80)
        }
        
    }
    //添加UI
    func addUIView() {
        username.backgroundColor=kYColor
        username.placeholder="请输入您的姓名"
        username.textAlignment = .center
        username.clearButtonMode = .whileEditing
        self.view.addSubview(username)
        username.snp.makeConstraints { (make) in
            make.top.equalTo(topImage.snp.bottom).offset(40)
            make.height.equalTo(44)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
        }
        
        pwd.backgroundColor=kYColor
        pwd.placeholder="请输入您的密码"
        pwd.textAlignment = .center
        pwd.isSecureTextEntry = true
        pwd.clearButtonMode = .whileEditing
        self.view.addSubview(pwd)
        pwd.snp.makeConstraints { (make) in
            make.top.equalTo(username.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.left.equalTo(username)
            make.right.equalTo(username)
        }
        
        confirmBtn.backgroundColor=KBackGroundColor
        confirmBtn.setTitle("登录", for: .normal)
        confirmBtn.setTitleColor(kYColor, for: .normal)
        confirmBtn.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
        self.view.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pwd.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.left.equalTo(pwd)
            make.right.equalTo(pwd)
        }
        
        toRegisterBtn.backgroundColor=UIColor.white
        toRegisterBtn.setTitleColor(KBackGroundColor, for: .normal)
        toRegisterBtn.titleLabel?.font=kAssistFont
        toRegisterBtn.setTitle("还没有账号？去注册!", for: .normal)
        toRegisterBtn.addTarget(self, action:#selector(goLogin(_:)), for: .touchUpInside)
        self.view.addSubview(toRegisterBtn)
        toRegisterBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(confirmBtn.snp.bottom).offset(10)
            make.left.equalTo(pwd)
            make.right.equalTo(pwd)
        }
        
    }
    
    func goLogin(_ button:UIButton)  {
        self.navigationController?.pushViewController(RegisterController() , animated: true)
    }
    
    func loginAction(_ button:UIButton) {
        let name = username.text;
        let password = pwd.text;
        print("name\(name)")
        if((name?.isEmpty)! || (password?.isEmpty)!){
            self.view.makeToast("请填全信息!", duration: 1, position: ToastPosition.center)
            return
        }
        
        let parameters: Parameters = ["username": name!,"password":password!]
        Alamofire.request(login, parameters:parameters,headers: headers).responseString { response in
            switch response.result {
            case .success(let value):
                if let user = JSONDeserializer<LoginInfo>.deserializeFrom(json: value) {
                    let userutil = UserUtils();
                    
                    if  user.objectId != nil
                    {
                        userutil.setUserId(userid: user.objectId!)
                        self.navigationController?.pushViewController(MainController() , animated: true)
                    }else{
                        
                        self.view.makeToast("用信息不存在", duration: 1, position: ToastPosition.center)
                    }
                    
                    
                }else{
                    
                    
                    self.view.makeToast("用户名或密码错误!", duration: 1, position: ToastPosition.center)
                }
            case .failure(let error):
                print("failure\(error)")
            }
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

