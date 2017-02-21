//
//  DetailViewController.swift
//  08-SwiftyJSONDemo
//
//  Created by 买明 on 21/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Dictionary<String, String>!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard detailItem != nil else { return }
        
        if let body = detailItem["content"] {
            var html = "<html>"
            html += "<head>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            
            // 加载 HTML
            webView.loadHTMLString(html, baseURL: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
