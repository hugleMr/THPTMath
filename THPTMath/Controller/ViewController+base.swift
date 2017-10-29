//
//  ViewController+base.swift
//  THPTMath
//
//  Created by hung le on 10/26/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension ViewController {
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 0.18, green: 0.59, blue: 0.88, alpha: 1);
        
        /*let leftBarButton = UIButton(type: .system);
         leftBarButton.setImage(#imageLiteral(resourceName: "btn_menu").withRenderingMode(.alwaysOriginal), for: .normal);
         leftBarButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34);*/
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_menu")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItemStyle.done, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
    }
    
    func setTitleNavigationBar(title : String){
        
        self.navigationItem.title = title;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
    }
    
    func getDataFromJson(url: String,completion: @escaping (_ success: DataResponse<Any>) -> Void) {
        
        let myUrl: String = domain + url;
        
        Alamofire.request(myUrl,method: .get, encoding: JSONEncoding.default,
                          headers : self.headers).responseJSON { response in
            
            completion(response)
        }
    }
    
    func postDataWithParam(url: String,parameters:Parameters, completion: @escaping (_ success: DataResponse<Any>) -> Void){
        let myUrl: String = domain + url;
        
        Alamofire.request(myUrl,method: .post,parameters : parameters, encoding: URLEncoding(),
                          headers : self.headers).responseJSON { response in
            
            completion(response)
        }
    }
    
    func getRequestImage(url: String, completion: @escaping (_ success: DataResponse<Image>) -> Void) {
        Alamofire.request(url).responseImage { response in
            completion(response)
        }
    }
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width*0.1,
                                               y: self.view.frame.size.height - 100,
                                               width: self.view.frame.size.width*0.8,
                                               height: self.view.frame.size.height*0.065))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.5, delay: 1.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showMenuToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 26,
                                               y: self.view.frame.size.height - 65,
                                               width: self.view.frame.size.width*0.65,
                                               height: self.view.frame.size.height*0.05))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 8.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 8;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.5, delay: 1.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showLoading(uiView: UIView) {
        container_loading.frame = uiView.frame
        container_loading.center = uiView.center
        container_loading.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0,y: 0,width: 80,height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0,y: 0,width: 40,height: 40)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,
                                           y: loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container_loading.addSubview(loadingView)
        uiView.addSubview(container_loading)
        activityIndicator.startAnimating()
    }
    
    func hideLoading(uiView: UIView) {
        activityIndicator.stopAnimating()
        container_loading.removeFromSuperview()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
