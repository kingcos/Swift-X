//
//  ViewController.swift
//  04-WebKitDemo
//
//  Created by 买明 on 20/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,
                      WKNavigationDelegate {

    // WKWebView 网页
    var webView: WKWebView!
    // UIProgressView 进度条
    var progressView: UIProgressView!
    var websites = Array<String>()
    
    override func loadView() {
        print(#function)
        
        webView = WKWebView()
        webView.navigationDelegate = self
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        websites += ["maimieng.com", "github.com/kingcos", "hackingwithswift.com"]
        
        guard let url = URL(string: "https://" + websites[0]) else { return }
        
        // 默认加载第一个
        webView.load(URLRequest(url: url))
        // 手势后退前进
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "打开",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openTapped))
        
        // 进度条控件
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        // 包装为 UIBarButtonItem
        let progressButtonItem = UIBarButtonItem(customView: progressView)
        // 弹性空白区域
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // 刷新按钮
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButtonItem, spacerItem, refreshItem]
        navigationController?.isToolbarHidden = false
        
        // 监听 webView 加载进度
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 加载完成，显示标题
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // 取得请求的 URL
        let url = navigationAction.request.url
        
        // 取得主机地址
        if let host = url?.host {
            for website in websites {
                // 如果链接的主机地址是 websites 中的链接，才跳转
                if host.range(of: website) != nil {
                    print("decisionHandler(.allow)")
                    decisionHandler(.allow)
                    return
                }
            }
        }
        print("decisionHandler(.cancel)")
        decisionHandler(.cancel)
    }
    
    // 观察进度值（转换类型）
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openTapped() {
        let alertController = UIAlertController(title: "打开...",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        for website in websites {
            alertController.addAction(UIAlertAction(title: website,
                                                    style: .default,
                                                    handler: openWebsite))
        }
        
        present(alertController, animated: true)
    }
    
    func openWebsite(action: UIAlertAction) {
        guard let url = URL(string: "https://" + action.title!) else { return }
        
        webView.load(URLRequest(url: url))
    }

}

