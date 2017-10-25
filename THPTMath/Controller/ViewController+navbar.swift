//
//  ViewController+navbar.swift
//  THPTMath
//
//  Created by hung le on 10/26/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit

extension ViewController {
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 0.18, green: 0.59, blue: 0.88, alpha: 1);
        
        /*let leftBarButton = UIButton(type: .system);
         leftBarButton.setImage(#imageLiteral(resourceName: "btn_menu").withRenderingMode(.alwaysOriginal), for: .normal);
         leftBarButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34);*/
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_menu")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItemStyle.done, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
    }
}
