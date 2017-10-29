//
//  MenuViewController.swift
//  THPTMath
//
//  Created by HungLe on 10/25/17.
//  Copyright © 2017 HungLe. All rights reserved.
//
// content/get-test.php

import UIKit
import SwiftyJSON
import FBSDKLoginKit

class MenuViewController: ViewController,UITableViewDelegate,UITableViewDataSource,
UITextFieldDelegate{
    
    var menu_names:Array = [String]();
    
    var image_icons = [UIImage]();
    
    var dict : [String : AnyObject]!
    
    var distance_keyboard: CGFloat = 0.0;
    var duration: Double = 0.0;
    
    var animCur:UIViewAnimationOptions!;
    
    @IBOutlet weak var background_bottom: UIButton!
    
    @IBOutlet weak var bottomConstant_popup: NSLayoutConstraint!
    
    @IBOutlet weak var bottomConstant_popupRegister: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_title: UILabel!
    
    @IBOutlet weak var btn_signin: UIButton!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var editbox_user_login: UITextField!
    
    @IBOutlet weak var editbox_password_login: UITextField!
    
    @IBOutlet weak var editbox_user_register: UITextField!
    
    @IBOutlet weak var editbox_password_register: UITextField!
    
    @IBOutlet weak var editbox_repassword_register: UITextField!
    
    @IBOutlet weak var editbox_fullname: UITextField!
    
    @IBOutlet weak var editbox_email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu_names = ["Đề thi","Chuyên đề","Kiểm tra","Lịch sử","Đăng xuất"];
        image_icons = [UIImage(named: "ic_exam")!,
                       UIImage(named: "ic_category")!,
                       UIImage(named: "ic_contest")!,
                       UIImage(named: "ic_history")!,
                       UIImage(named: "ic_logout")!];
        
        avatar.layer.borderColor = UIColor.black.cgColor;
        avatar.layer.borderWidth = 2;
        avatar.layer.cornerRadius = 32;
        avatar.layer.masksToBounds = false;
        avatar.clipsToBounds = true;
        
        let username = UserDefaults.standard.string(forKey: "username");
        let password = UserDefaults.standard.string(forKey: "password");
        if(username != nil && password != nil){
            editbox_user_login.text! = username!;
            editbox_password_login.text! = password!;
            
            //login(username: username!,password: password!);
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        self.duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        
        let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
        animCur = UIViewAnimationOptions(rawValue: animationCurveRaw)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            self.distance_keyboard = keyboardViewEndFrame.height;
            self.moveTextField(animCur: animCur, up: false);
        } else {
            self.distance_keyboard = keyboardViewEndFrame.height;
            self.moveTextField(animCur: animCur,up: true);
        }
    }
    
    @IBAction func registerNormal(_ sender: UIButton) {
        /*
         username": String username
         "password": String password
         "fullname": String fullname
         "email": String email

         */
        if(self.editbox_user_register.text?.isEmpty ?? true ||
            self.editbox_password_register.text?.isEmpty ?? true ||
            self.editbox_fullname.text?.isEmpty ?? true ||
            self.editbox_email.text?.isEmpty ?? true) {
                
            showMenuToast(message: "Điền vào ô còn trống");
        }else{
            let username = String(self.editbox_user_register.text!);
            let password = String(self.editbox_password_register.text!);
            let fullname = String(self.editbox_fullname.text!);
            let email = String(self.editbox_email.text!);
            
            let parameters: [String: Any] = [
                "username": username,
                "password": password,
                "fullname": fullname,
                "email": email
            ]
            
            postDataWithParam(url: "user/register.php",parameters: parameters, completion: { response in
                if(response.result.value != nil) {
                    let swiftyJsonVar = JSON(response.result.value!)
                    
                    /*
                     "message" : "Đăng ký thành công",
                     "status" : "200",
                     "success" : true
                     */
                    
                    let message = swiftyJsonVar["message"].object as! String;
                    let status = swiftyJsonVar["status"].object as! String;
                    let success = swiftyJsonVar["success"].object as! Bool;
                    
                    if(status == "200" && success) {
                        UserDefaults.standard.set(username, forKey: "username")
                        UserDefaults.standard.set(password, forKey: "password")
                        
                        self.showMenuToast(message: message);
                        self.view.endEditing(true)
                        self.closePopup();
                    }
                }
            })
        }
    }
    
    func loginFb(){
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "picture.width(128).height(128),id,name,email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let swiftyJsonVar = JSON(result as! [String : AnyObject])
                    
                    if let name: String = swiftyJsonVar["name"].object as? String {
                        self.lblName.text! = name;
                    }
                    if let email: String = swiftyJsonVar["email"].object as? String {
                        self.lblEmail.text! = email;
                    }
                    
                    let dict = result as! NSDictionary
                    if let picture = dict.object(forKey: "picture") as? NSDictionary{
                        if let data = picture.object(forKey: "data") as? NSDictionary {
                            if let url = data.object(forKey: "url") as? String {
                                self.getRequestImage(url: url, completion: { response in
                                    if let image = response.result.value {
                                        self.avatar.image = image;
                                    }
                                })
                            }
                        }
                    }
                    
                    self.btn_signin.isHidden = true;
                    self.view.endEditing(true)
                    self.closePopup();
                    
                }else{
                    print("error as Any")
                    print(error as Any)
                }
            })
        }
    }
    
    @IBAction func loginfacebook(_ sender: UIButton) {
        loginFb();
    }
    
    
    func login(username: String,password: String){
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        postDataWithParam(url: "user/login.php",parameters: parameters, completion: { response in
            if(response.result.value != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                
                let status = swiftyJsonVar["status"].object as! String;
                if(status == "200") {
                    let resData = swiftyJsonVar["data"].object as! [String:AnyObject];
                    let email = resData["email"] as! String;
                    let name = resData["fullname"] as! String;
                    
                    if (email.isEmpty || name.isEmpty) {
                        self.showMenuToast(message: "Sai tên hoặc mật khẩu.")
                    }else {
                        UserDefaults.standard.set(username, forKey: "username")
                        UserDefaults.standard.set(password, forKey: "password")
                        
                        self.btn_signin.isHidden = true;
                        self.lblName.text! = name;
                        self.lblEmail.text! = email;
                        
                        self.view.endEditing(true)
                        self.closePopup();
                    }
                }else{
                    self.showMenuToast(message: "Fail login!")
                }
            }
        })
    }
    
    @IBAction func loginNormal(_ sender: UIButton) {
        if(self.editbox_user_login.text?.isEmpty ?? true ||
            self.editbox_password_login.text?.isEmpty ?? true){
            showMenuToast(message: "Điền vào ô còn trống");
        }else{
            let username = String(self.editbox_user_login.text!)
            let password = String(self.editbox_password_login.text!)
            
            login(username: username,password: password);
        }
    }
    
    @IBAction func backFromeRegisterToLogin(_ sender: UIButton) {
        self.view.endEditing(true)
        bottomConstant_popupRegister.constant = -400;
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded();
        }, completion: { (finished) in
            self.bottomConstant_popup.constant = 20;
            UIView.animate(withDuration: 0.3, animations: {
                self.background_bottom.alpha = 0.5;
            })
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded();
            }, completion: nil);
        })
    }
    
    @IBAction func showPopupRegister(_ sender: MButton) {
        self.view.endEditing(true)
        bottomConstant_popup.constant = -400;
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded();
        }, completion: { (finished) in
            self.bottomConstant_popupRegister.constant = 20;
            UIView.animate(withDuration: 0.3, animations: {
                self.background_bottom.alpha = 0.5;
            })
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded();
            }, completion: nil);
        })
    }
    
    func closePopup(){
        self.view.endEditing(true)
        
        if(bottomConstant_popup.constant > 0){
            bottomConstant_popup.constant = -400
        }
        
        if(bottomConstant_popupRegister.constant > 0){
            bottomConstant_popupRegister.constant = -400
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded();
            self.background_bottom.alpha = 0;
        })
    }
    
    @IBAction func closePopupLogin(_ sender: UIButton) {
        self.closePopup();
    }
    
    @IBAction func showPopupLogin(_ sender: UIButton) {
        bottomConstant_popup.constant = 20;
        
        UIView.animate(withDuration: 0.3, animations: {
            self.background_bottom.alpha = 0.5;
        })
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded();
        }, completion: nil);
    }
    
    //====== TextField
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == editbox_user_login){
            
        }else if(textField == editbox_password_login){
            
        }else if(textField == editbox_user_register){
            
        }else if(textField == editbox_password_register){
            
        }else if(textField == editbox_repassword_register){
            
        }else if(textField == editbox_fullname){
            
        }else if(textField == editbox_email){
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == editbox_user_login){
            editbox_password_login.becomeFirstResponder();
        }else if(textField == editbox_password_login){
            textField.resignFirstResponder();
        }else if(textField == editbox_user_register){
            editbox_password_register.becomeFirstResponder();
        }else if(textField == editbox_password_register){
            editbox_repassword_register.becomeFirstResponder();
        }else if(textField == editbox_repassword_register){
            editbox_fullname.becomeFirstResponder();
        }else if(textField == editbox_fullname){
            editbox_email.becomeFirstResponder();
        }else if(textField == editbox_email){
            textField.resignFirstResponder();
        }
        
        return true;
    }
    
    func moveTextField(animCur: UIViewAnimationOptions, up: Bool) {
        var viewFrame: CGRect = self.view.frame;
        let move: CGFloat = up ? -self.distance_keyboard : 0;
        viewFrame.origin.y = move;
        
        self.view.frame = viewFrame;
        
        UIView.animate(withDuration: self.duration,
                       delay: TimeInterval(0),
                       options: animCur,
                       animations: { self.view.layoutIfNeeded() },
                       completion: nil)
    }
    
    //======= TableView
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //tableView.contentInset = UIEdgeInsetsMake(UIApplication.shared.statusBarFrame.height,0,0,0);
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu_names.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell;
        
        cell.image_icon.image = image_icons[indexPath.row];
        cell.name_icon.text! = menu_names[indexPath.row];
        
        return cell;
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reavelView :SWRevealViewController = self.revealViewController();
        
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell;
        
        if (cell.name_icon.text! == "Đề thi"){
            let main_story:UIStoryboard = UIStoryboard(name : "Main", bundle : nil);
            let desc = main_story.instantiateViewController(withIdentifier: "ExamController") as! ExamController;
            
            let new_front_viewcontroller = UINavigationController.init(rootViewController: desc);
            reavelView.pushFrontViewController(new_front_viewcontroller, animated: true);
        }
        if (cell.name_icon.text! == "Chuyên đề"){
            let main_story:UIStoryboard = UIStoryboard(name : "Main", bundle : nil);
            let desc = main_story.instantiateViewController(withIdentifier: "CategoryController") as! CategoryController;
            
            let new_front_viewcontroller = UINavigationController.init(rootViewController: desc);
            reavelView.pushFrontViewController(new_front_viewcontroller, animated: true);
        }
        if (cell.name_icon.text! == "Kiểm tra"){
            let main_story:UIStoryboard = UIStoryboard(name : "Main", bundle : nil);
            let desc = main_story.instantiateViewController(withIdentifier: "ContestController") as! ContestController;
            
            let new_front_viewcontroller = UINavigationController.init(rootViewController: desc);
            reavelView.pushFrontViewController(new_front_viewcontroller, animated: true);
        }
        if (cell.name_icon.text! == "Lịch sử"){
            let main_story:UIStoryboard = UIStoryboard(name : "Main", bundle : nil);
            let desc = main_story.instantiateViewController(withIdentifier: "HistoryController") as! HistoryController;
            
            let new_front_viewcontroller = UINavigationController.init(rootViewController: desc);
            reavelView.pushFrontViewController(new_front_viewcontroller, animated: true);
        }
        if (cell.name_icon.text! == "Đăng xuất"){
            self.showMenuToast(message: "Éo cho đăng xuất đấy :|");
        }
    }

}
