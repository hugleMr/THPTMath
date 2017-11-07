//
//  ContestController.swift
//  THPTMath
//
//  Created by hung le on 10/26/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ContestController: ViewController{

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contestHeaderView: ContestHeaderView!
    var data_questions:Array = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar();
        setTitleNavigationBar(title: "KIỂM TRA");
        
        containerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        self.showLoading(uiView: self.view);
        
        let parameters: [String: Any] = [
            "cateIDs": "1",
            "page": "50"
        ]
        
        getDataFromJsonWithNoneEncode(url: "content/exam.php", parameters: parameters, completion: { response in
            
            self.hideLoading(uiView: self.view);
            
            if(response.result.value != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                
                var data = [[String:Any]]()
                
                if let resData = swiftyJsonVar["data"].arrayObject {
                    data = resData as! [[String:AnyObject]]
                }
                
                var index: Int = 0
                for myData in data {
                    
                    let mathUtils = MathUtils()
                    
                    index += 1
                    if let question: String = myData["question"] as? String {
                        mathUtils.question = "<b>" + "Câu hỏi" + " " +
                            "\(index)" + "</b>: " + mathUtils.replaceMath(string: question)
                    }
                    
                    if let answerA: String = myData["answerA"] as? String {
                        mathUtils.answer1 = mathUtils.replaceMath(string: answerA)
                    }
                    
                    if let answerB: String = myData["answerB"] as? String {
                        mathUtils.answer2 = mathUtils.replaceMath(string: answerB)
                    }
                    
                    if let answerC: String = myData["answerC"] as? String {
                        mathUtils.answer3 = mathUtils.replaceMath(string: answerC)
                    }
                    
                    if let answerD: String = myData["answerD"] as? String {
                        mathUtils.answer4 = mathUtils.replaceMath(string: answerD)
                    }
                    
                    if let image: String = myData["image"] as? String {
                        mathUtils.image = image;
                    }
                    
                    self.data_questions.append(mathUtils.htmlContain());
                }
                
                if(self.data_questions.count > 0){
                    DispatchQueue.global().async(execute: {
                        DispatchQueue.main.sync{
                            self.performSegue(withIdentifier: "ShowContestPageViewController", sender: self)
                        }
                    })
                }
            }
        })
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowContestPageViewController" && self.data_questions.count > 0) {
            if let contestPageVC = segue.destination as? ContestPageViewController {
                contestPageVC.jsStrings = self.data_questions
                contestPageVC.contestPageViewController = contestHeaderView
            }
        }
    }
    
    override func loadView() {
        super.loadView()
    }
}
