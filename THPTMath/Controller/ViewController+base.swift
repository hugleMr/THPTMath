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
    
    func getDataFromJson(url: String,completion: @escaping (_ success: DataResponse<Any>) -> Void) {
        
        let myUrl: String = "http://mathpt.webstarterz.com/api/" + url;
        
        let headers: HTTPHeaders = [
            "X-Math-Api-Key": "manh123@abc"
        ]
        
        Alamofire.request(myUrl,method: .get, encoding: JSONEncoding.default,headers : headers).responseJSON { response in
            
            completion(response)
            
            /*if let json = response.result.value {
                //print("JSON: \(json)") // serialized json response
                
            }*/
            
            /*if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
             print("Data: \(utf8Text)") // original server data as UTF8 string
             }*/
        }
    }
    
    func getData(api_link: String) -> String {
        
        var data_value = "";
        
        // Set up the URL request
        let todoEndpoint: String = "http://mathpt.webstarterz.com/api/" + api_link
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return ""
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue("manh123@abc", forHTTPHeaderField: "X-Math-Api-Key")
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                //print("The todo is: " + todo.description)
                
                data_value = todo.description;
                
                /*guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)*/
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
        
        return data_value;
    }
}
