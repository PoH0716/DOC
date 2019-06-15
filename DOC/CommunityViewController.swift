//
//  CommunityViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/19/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit
import WebKit

class CommunityViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var pdfView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfView.uiDelegate = self
        spinner.hidesWhenStopped = true
        
        let path = Bundle.main.path(forResource: "CommunityGuide", ofType: "pdf")
        let myUrl = URL(fileURLWithPath: path!)
        let request = URLRequest(url: myUrl)
        pdfView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        spinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinishNavigation navigation: WKNavigation) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailNavigation navigation: WKNavigation, withError error: NSError) {
        spinner.stopAnimating()
        print("oops!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
