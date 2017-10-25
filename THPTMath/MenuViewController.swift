//
//  MenuViewController.swift
//  THPTMath
//
//  Created by HungLe on 10/25/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var menu_names:Array = [String]();
    var image_icons = [UIImage]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu_names = ["Setting","Chat","Email","Lock"];
        image_icons = [UIImage(named: "btn_caidat")!,UIImage(named: "btn_chat")!,
                       UIImage(named: "btn_email")!,UIImage(named: "btn_khoa")!];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if (cell.name_icon.text! == "Setting"){
            let main_story:UIStoryboard = UIStoryboard(name : "Main", bundle : nil);
            let desc = main_story.instantiateViewController(withIdentifier: "ViewController") as! ViewController;
            
            let new_front_viewcontroller = UINavigationController.init(rootViewController: desc);
            reavelView.pushFrontViewController(new_front_viewcontroller, animated: true);
        }
        if (cell.name_icon.text! == "Chat"){
            let main_story:UIStoryboard = UIStoryboard(name : "Main", bundle : nil);
            let desc = main_story.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController;
            
            let new_front_viewcontroller = UINavigationController.init(rootViewController: desc);
            reavelView.pushFrontViewController(new_front_viewcontroller, animated: true);
        }
    }

}
