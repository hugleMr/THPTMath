//
//  ViewController+base.swift
//  THPTMath
//
//  Created by hung le on 10/26/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit
import Alamofire

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
        
        let myUrl: String = "http://mathpt.webstarterz.com/api/" + url;
        
        let headers: HTTPHeaders = [
            "X-Math-Api-Key": "manh123@abc"
        ]
        
        Alamofire.request(myUrl,method: .get, encoding: JSONEncoding.default,headers : headers).responseJSON { response in
            
            completion(response)
        }
    }
}
