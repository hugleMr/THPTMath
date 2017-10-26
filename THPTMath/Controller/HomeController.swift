//
//  HomeController.swift
//  THPTMath
//
//  Created by HungLe on 10/26/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeController: ViewController {

    var data = [[String:Any]]()
    var authors: [String] = []
    var names: [String] = []
    var contacts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar();
        
        getDataFromJson(url: "content/get-test.php", completion: { response in
            
            if let data = response.result.value{
                let swiftyJsonVar = JSON(data)
                print(swiftyJsonVar)
            }
            
            /*if response.result.value != nil{
                if((response.result.value) != nil) {
                    let swiftyJsonVar = JSON(response.result.value!)
                    
                    if let resData = swiftyJsonVar["data"].arrayObject {
                        self.data = resData as! [[String:AnyObject]]
                    }
                    
                    for myData in self.data {
                        self.authors.append(myData["author"] as! String);
                    }
                    if self.authors.count > 0 {
                        print(self.authors)
                    }
                }
            }*/
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
