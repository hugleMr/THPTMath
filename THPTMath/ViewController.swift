//
//  ViewController.swift
//  THPTMath
//
//  Created by HungLe on 10/25/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bar_menu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bar_menu.target = revealViewController();
        bar_menu.action = #selector(SWRevealViewController.revealToggle(_:));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

