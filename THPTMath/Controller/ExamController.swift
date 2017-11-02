//
//  ExamController.swift
//  THPTMath
//
//  Created by hung le on 10/26/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit
import SwiftyJSON

struct examObject {
    let title: String
    let body: String
}

class ExamController: ViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    var list_exams:Array = [examObject]();
    var data = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar();
        setTitleNavigationBar(title: "BỘ ĐỀ");
        
        self.showLoading(uiView: self.view);
        
        /*let parameters: [String: Any] = [
            "type": "1",
            "cateID": "1"
        ]*/
        
        getDataFromJson(url: "content/get-test.php", parameters: nil, completion: { response in
            
            self.hideLoading(uiView: self.view);
            
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
                    let name = myData["author"] as! String;
                    let title = myData["displayname"] as! String;
                    let object_exam = examObject(title: title,body: name);
                    self.list_exams.append(object_exam);
                }
                
                if(self.list_exams.count > 0){
                    self.myTableView.reloadData();
                }
            }
        })
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TO DO
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list_exams.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ExamTableViewCell;
        
        cell.myTitle.text! = self.list_exams[indexPath.row].title;
        cell.myBody.text! = self.list_exams[indexPath.row].body;
        
        return cell;
    }
}
