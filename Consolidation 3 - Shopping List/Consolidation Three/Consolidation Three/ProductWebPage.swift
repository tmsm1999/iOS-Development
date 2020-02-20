//
//  ProductWebPage.swift
//  Consolidation Three
//
//  Created by Tomás Santiago on 17/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit
import WebKit

class ProductWebPage: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var item: String!
    var progressView: UIProgressView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        print("aqui")
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareProductLink))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        
        navigationController?.setToolbarHidden(false, animated: true)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressBar = UIBarButtonItem(customView: progressView)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        toolbarItems = [progressBar, space, shareButton]
        
        openWebPage()
    }
    
    @objc func shareProductLink() {
        
        if let itemURL = webView.url {
            
             let actionView = UIActivityViewController(activityItems: [itemURL], applicationActivities: [])
            present(actionView, animated: true, completion: nil)
        }
        
        return
    }
    
    func openWebPage() {
        
        guard let itemToShow = item else {
            return
        }
        
        guard let itemURL = URL(string: "https://www.continente.pt/pt-pt/public/Pages/searchresults.aspx?k=\(itemToShow)") else {
            print("Exit with error!")
            return
        }
            
        print(itemURL)
        webView.load(URLRequest(url: itemURL))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        title = item
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
