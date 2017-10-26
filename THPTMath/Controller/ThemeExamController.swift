//
//  ThemeExamController.swift
//  THPTMath
//
//  Created by hung le on 10/26/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit
import SwiftyJSON

struct themeExamObject {
    let id: String
    let name: String
    let countQuestion: String
}

class ThemeExamController: ViewController,UITableViewDelegate,UITableViewDataSource {

    var list_themeExams:Array = [themeExamObject]();
    var data = [[String:Any]]()
    
    @IBOutlet weak var myThemeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar();
        setTitleNavigationBar(title: "CHUYÊN ĐỀ");
        /*
         "id" : "4",
         "name" : "Số phức",
         "countQuestion" : "54"
         */
        
        getDataFromJson(url: "content/get-category.php", completion: { response in
            
            /*if let data = response.result.value{
                let swiftyJsonVar = JSON(data)
                print(swiftyJsonVar)
            }*/
            
            if(response.result.value != nil) {
                let swiftyJsonVar = JSON(response.result.value!)

                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.data = resData as! [[String:AnyObject]]
                }

                for myData in self.data {
                    let id = myData["id"] as! String;
                    let name = myData["name"] as! String;
                    let count = myData["countQuestion"] as! String;
                    
                    let object_themExam = themeExamObject(id: id,name: name,countQuestion: count);
                    self.list_themeExams.append(object_themExam);
                }

                if(self.list_themeExams.count > 0){
                    self.myThemeTableView.reloadData();
                }
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list_themeExams.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ThemeExamTableViewCell;
        
        cell.myImage.image = UIImage(named: ("icon_" + self.list_themeExams[indexPath.row].id));
        cell.myTitle.text! = self.list_themeExams[indexPath.row].name;
        
        return cell;
    }
}
