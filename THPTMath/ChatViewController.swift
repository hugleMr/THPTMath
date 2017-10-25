//
//  ChatViewController.swift
//  THPTMath
//
//  Created by HungLe on 10/25/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var btn_menu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_menu.target = revealViewController();
        btn_menu.action = #selector(SWRevealViewController.revealToggle(_:));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
