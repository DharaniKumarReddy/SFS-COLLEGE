//
//  WebViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 29/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    internal var webUrlString: String?
    
    var webView: WKWebView!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 20) - 44 - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)), configuration: webConfiguration)
        webView.navigationDelegate = self
        view.insertSubview(webView, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBackWithNoText()
        title = "SFS COLLEGE"
        let myURL = URL(string: webUrlString ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
