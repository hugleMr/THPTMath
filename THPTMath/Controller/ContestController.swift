//
//  ContestController.swift
//  THPTMath
//
//  Created by hung le on 10/26/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit
import SwiftyJSON
import WebKit

class ContestController: ViewController,WKUIDelegate,WKScriptMessageHandler {

    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar();
    }
    
    override func loadView() {
        super.loadView()
        
        let contentController = WKUserContentController();
        contentController.add(self,name: "callbackHandler")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView?.uiDelegate = self
        view = webView
        _ = webView?.load(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "html")!)))
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
    {
        if(message.name == "callbackHandler") {
            print("JavaScript is sending a message \(message.body)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
