//
//  MenuViewController.swift
//  THPTMath
//
//  Created by HungLe on 10/25/17.
//  Copyright © 2017 HungLe. All rights reserved.
//
// content/get-test.php

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var menu_names:Array = [String]();
    var image_icons = [UIImage]();
    
    @IBOutlet weak var avatar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu_names = ["Đề thi","Chuyên đề","Kiểm tra","Đăng xuất"];
        image_icons = [UIImage(named: "icon_home")!,UIImage(named: "icon_setting")!,
                       UIImage(named: "icon_chat")!,
                       UIImage(named: "icon_email")!];
        
        avatar.layer.borderColor = UIColor.black.cgColor;
        avatar.layer.borderWidth = 2;
        avatar.layer.cornerRadius = 64;
        avatar.layer.masksToBounds = false;
        avatar.clipsToBounds = true;
        
        let urlString = URL(string: "http://mathpt.webstarterz.com/api/content/get-test.php")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let usableData = data {
                        print(usableData) //JSONSerialization
                    }
                }
            }
            task.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        tableView.contentInset = UIEdgeInsetsMake(UIApplication.shared.statusBarFrame.height, 0, 0, 0);
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
            let desc = main_story.instantiateViewController(withIdentifier: "ThemeExamController") as! ThemeExamController;
            
            let new_front_viewcontroller = UINavigationController.init(rootViewController: desc);
            reavelView.pushFrontViewController(new_front_viewcontroller, animated: true);
        }
        if (cell.name_icon.text! == "Kiểm tra"){
            let main_story:UIStoryboard = UIStoryboard(name : "Main", bundle : nil);
            let desc = main_story.instantiateViewController(withIdentifier: "ContestController") as! ContestController;
            
            let new_front_viewcontroller = UINavigationController.init(rootViewController: desc);
            reavelView.pushFrontViewController(new_front_viewcontroller, animated: true);
        }
        if (cell.name_icon.text! == "Đăng xuất"){
            
        }
    }

}
