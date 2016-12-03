//
//  ViewController.swift
//  MySecond
//
//  Created by lixs on 2016/11/24.
//  Copyright © 2016年. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import HandyJSON
import Toast_Swift

class MainController: UIViewController {
    
    lazy var topImage = UIImageView();
    //圆形点击查询按钮
    lazy var queryPwd = UITextView();
    //圆形点击添加车辆按钮
    lazy var inputPwd = UITextView();
    //弹出框输入框
    var queryEdite : UITextField?;
    //弹出框背景
    let boxView = UIView();
    //弹出框父view
    let bView = UIView();
    //查询确定按钮
    var queryConfirmBtn : UIButton?;
    //添加车辆对话框车牌输入框
    var addBikeNumEdite : UITextField?;
    //添加车辆对话框车密码输入框
    var addBikePwdEdite : UITextField?;
    //添加车辆对话框确认按钮
    var addBikeConfirmBtn : UIButton?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 2.0)
        
        self.title = "OZO"
        //修改下个视图的导航栏
        //        let item = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        //        self.navigationItem.backBarButtonItem = item;
        self.navigationItem.hidesBackButton = true
        
        addTopImage();
        addButtons(textview: queryPwd,text: "查询密码",marginView: topImage,tag:1);
        addButtons(textview: inputPwd,text: "添加车辆",marginView: queryPwd,tag:2);
        initGestor();
    }
    
    func initGestor() {
        let singleTap1 = UITapGestureRecognizer(target: self, action: #selector(singleTapAction(tap:)))
        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(singleTapAction(tap:)))
        queryPwd.addGestureRecognizer(singleTap1);
        inputPwd.addGestureRecognizer(singleTap2);
    }
    
    func singleTapAction(tap:UITapGestureRecognizer) {
        switch tap.view!.tag {
        case 1:
            alterQueryBox();
        case 2:
            alertAddBikeBox();
        default:
            print("default")
        }
    }
    
    func closeBox(_ button:UIButton) {
        rmoveChildrenViews(view:bView)
    }
    
    func rmoveChildrenViews(view:UIView) {
        for v in view.subviews{
            v.removeFromSuperview()
            rmoveChildrenViews(view: v)
        }
        view.removeFromSuperview()
    }
    
    //添加自行车弹框
    func alertAddBikeBox() {
        addBoxBackView();
        addBoxFrame(height: 200);
        addBoxCloseBtn();
        //车牌输入框
        addBikeNumEdite = UITextField();
        addBikeNumEdite?.backgroundColor=kYColor
        addBikeNumEdite?.placeholder="请输入车牌号"
        addBikeNumEdite?.minimumFontSize=14
        addBikeNumEdite?.textAlignment = .center
        addBikeNumEdite?.clearButtonMode = .whileEditing
        addBikeNumEdite?.keyboardType = .numberPad
        addBikeNumEdite?.isEnabled=true
        addBikeNumEdite?.text=nil
        boxView.addSubview(addBikeNumEdite!)
        addBikeNumEdite?.snp.makeConstraints { (make) in
            make.centerX.equalTo(boxView)
            make.height.equalTo(40)
            make.top.equalTo(44)
            make.left.equalTo(boxView).offset(30)
            make.right.equalTo(boxView).offset(-30)
        }
        
        addBikePwdEdite = UITextField();
        addBikePwdEdite?.backgroundColor=kYColor
        addBikePwdEdite?.placeholder="请输入车密码"
        addBikePwdEdite?.minimumFontSize=14
        addBikePwdEdite?.textAlignment = .center
        addBikePwdEdite?.clearButtonMode = .whileEditing
        addBikePwdEdite?.keyboardType = .numberPad
        addBikePwdEdite?.isEnabled=true
        addBikePwdEdite?.text=nil
        boxView.addSubview(addBikePwdEdite!)
        addBikePwdEdite?.snp.makeConstraints { (make) in
            make.centerX.equalTo(boxView)
            make.height.equalTo(40)
            make.top.equalTo((addBikeNumEdite?.snp.bottom)!).offset(10)
            make.left.equalTo(boxView).offset(30)
            make.right.equalTo(boxView).offset(-30)
        }
        
        //确定按钮
        addBikeConfirmBtn = UIButton();
        addBikeConfirmBtn?.setTitle("添加车辆", for: .normal)
        addBikeConfirmBtn?.setTitleColor(kYColor, for: .normal)
        addBikeConfirmBtn?.isEnabled=true
        addBikeConfirmBtn?.addTarget(self, action:#selector(addBikesActions(_:)), for:.touchUpInside)
        boxView.addSubview(addBikeConfirmBtn!)
        addBikeConfirmBtn?.snp.makeConstraints { (make) in
            make.width.equalTo(boxView)
            make.height.equalTo(30)
            make.centerX.equalTo(boxView)
            make.top.equalTo((addBikePwdEdite?.snp.bottom)!).offset(10)
        }
        
        
    }
    
    func addBoxBackView() {
        //背景蒙版
        bView.backgroundColor=KTranslateBackGround
        self.view.addSubview(bView)
        bView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }
    
    func addBoxFrame(height:Int) {
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
    
    func addBoxCloseBtn() {
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
    
    
    //查询按钮弹框
    func alterQueryBox(){
        
        addBoxBackView();
        addBoxFrame(height:190);
        addBoxCloseBtn();
        
        //输入框
        queryEdite = UITextField();
        queryEdite?.backgroundColor=kYColor
        queryEdite?.placeholder="请输入车牌号"
        queryEdite?.minimumFontSize=14
        queryEdite?.textAlignment = .center
        queryEdite?.clearButtonMode = .whileEditing
        queryEdite?.keyboardType = .numberPad
        queryEdite?.isEnabled=true
        queryEdite?.text=nil
        boxView.addSubview(queryEdite!)
        queryEdite?.snp.makeConstraints { (make) in
            make.centerX.equalTo(boxView)
            make.height.equalTo(80)
            make.top.equalTo(44)
            make.left.equalTo(boxView).offset(30)
            make.right.equalTo(boxView).offset(-30)
        }
        
        //确定按钮
        queryConfirmBtn = UIButton();
        queryConfirmBtn?.isEnabled=true
        queryConfirmBtn?.setTitle("立即骑车", for: .normal)
        queryConfirmBtn?.setTitleColor(kYColor, for: .normal)
        queryConfirmBtn?.addTarget(self, action:#selector(queryAction(_:)), for:.touchUpInside)
        boxView.addSubview(queryConfirmBtn!)
        queryConfirmBtn?.snp.makeConstraints { (make) in
            make.width.equalTo(boxView)
            make.height.equalTo(30)
            make.centerX.equalTo(boxView)
            make.top.equalTo((queryEdite?.snp.bottom)!).offset(10)
        }
        
    }
    
    //查询密码按钮点击事件
    func queryAction(_ button:UIButton){
        let textStr = queryEdite?.text
        if(textStr?.isEmpty)!{
            self.view.makeToast("车牌号不可以为空!")
            return
        }
        
        let parameters: Parameters = ["where": "{\"bike_num\":\"\(textStr!)\"}"]
        Alamofire.request(getBikePwd, parameters:parameters,headers: headers).responseString { response in
            switch response.result {
            case .success(let value):
                if let bike = JSONDeserializer<Results<BikeInfo>>.deserializeFrom(json: value) {
                    if((bike.results?.count)!>0){
                        let pwd = bike.results?[0].bike_pwd;
                        self.queryEdite?.text = "密码是:\(pwd!)"
                    }else{
                        self.queryEdite?.text = "没有车辆信息"
                    }
                    self.queryEdite?.isEnabled=false
                    self.queryConfirmBtn?.isEnabled=false
                    //                    self.queryEdite.isEnabled=false
                }
            case .failure(let error):
                print("failure\(error)")
            }
        }
        
    }
    
    //添加顶部图片
    func addTopImage(){
        topImage.image = UIImage(named: "bike")
        self.view.addSubview(topImage)
        topImage.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(80)
            make.top.equalTo(80)
            make.centerX.equalTo(self.view)
        }
    }
    
    //添加按钮
    func addButtons(textview:UITextView,text:String,marginView:UIView,tag:Int){
        textview.text=text
        textview.layer.borderWidth=0
        textview.layer.cornerRadius=50
        textview.textColor=kYColor
        textview.backgroundColor=KBackGroundColor
        textview.isEditable=false
        textview.tag=tag
        textview.isUserInteractionEnabled = true
        textview.isSelectable=false
        textview.textAlignment=NSTextAlignment.center
        textview.textContainerInset = UIEdgeInsetsMake(41, 0, 0, 0)
        textview.font=kBodyFont
        self.view.addSubview(textview)
        textview.snp.makeConstraints { (make) in
            make.top.equalTo(marginView.snp.bottom).offset(30)
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(100)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //添加车辆接口
    func addBikesActions(_:UIButton){
        if(((addBikeNumEdite?.text)?.isEmpty)! || ((addBikePwdEdite?.text)?.isEmpty)!){
            self.view.makeToast("请填全信息!")
            return
        }
        
        let url = URL(string: addBike)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let userUtil = UserUtils();
        let parameters =  ["contributoryId":userUtil.getUserId(),"bike_num":(addBikeNumEdite?.text)!,"bike_pwd":(addBikePwdEdite?.text)!]
        
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
                    if let user = JSONDeserializer<AddBikeInfo>.deserializeFrom(json: value) {
                        self.closeBox(UIButton());
                        self.view.makeToast("添加成功!")
                    }else{
                        self.view.makeToast("添加失败!")
                    }
                case .failure(let error):
                    print("failure\(error)")
                }
        }
        
    }
    
}




//        let alertController = UIAlertController(title:"提示",message:"请输入用户名和密码",preferredStyle: .alert)
//        alertController.addTextField{
//            (textField: UITextField!) -> Void in
//            textField.placeholder = "密码"
//            textField.isSecureTextEntry = true
//        }
////        alertController.view.backgroundColor=KBackGroundColor;
//
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//
//        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
//            action in
//            //也可以用下标的形式获取textField let login = alertController.textFields![0]
//            let login = alertController.textFields!.first!
//            let password = alertController.textFields!.last!
//            print("用户名：\(login.text) 密码：\(password.text)")
//        })
////        alertController.addAction(cancelAction)
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
