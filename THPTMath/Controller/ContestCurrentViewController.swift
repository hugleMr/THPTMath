//
//  ContestCurrentViewController.swift
//  THPTMath
//
//  Created by hung le on 11/5/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit
import WebKit

class ContestCurrentViewController: UIViewController,WKUIDelegate,WKScriptMessageHandler {

    var webView: WKWebView?
    
    var jsString: String? {
        didSet {
            webView?.loadHTMLString(jsString!, baseURL: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if jsString != nil {
            webView?.loadHTMLString(jsString!, baseURL: nil)
        }
    }
    
    override func loadView() {
        let contentController = WKUserContentController();
        contentController.add(self,name: "callbackHandler")
        
        var scriptContent = "var meta = document.createElement('meta');"
        scriptContent += "meta.name='viewport';"
        scriptContent += "meta.content='width=device-width';"
        scriptContent += "document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: scriptContent, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript);
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView?.uiDelegate = self
        view = webView
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
    {
        if(message.name == "callbackHandler") {
            //self.showToast(message: "JavaScript is sending a message \(message.body)")
        }
    }
}
