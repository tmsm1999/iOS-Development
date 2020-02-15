//
//  ViewController.swift
//  Easy Browser
//
//  Created by Tomás Santiago on 15/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit
import WebKit
//Neste projeto vamos utilizar WK WebView que faz parte da framework do WebKit.


class ViewController: UIViewController, WKNavigationDelegate {
    // O vírgula WKNavigationDelegate significa que promete implementar o protocolo WKNavigationDelegate.
    
    //Em primeiro lugar fui ao ficheiro Main.storyboard. Cliquei na view que lá está e fiz Editor -> Embed in -> Navigation Controller
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["facebook.com", "hackingwithswift.com", "youtube.com/watch?v=43sjym5ZS68"]
    
    override func loadView() {
        
        webView = WKWebView()
        webView.navigationDelegate = self
        
        //O que significa a segunda linha.
        //A web view que criamos precisa de algo que implemente funções para que funcione conrretamente. O compilador precisa de saber quem é que vai fazer este trabalho por delegação.
        //Ao dizermos = self significa que vamos confiar na classe que implementa a própria web view.
        
        view = webView //Cada ViewController tem uma view associada.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTappedWebsite))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let goBackButton = UIBarButtonItem(title: "Go back", style: .plain, target: webView, action: #selector(webView.goBack))
        
//        let goForwardButton = UIBarButtonItem(title: "Go Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        //Para colocar o forward button descomentar a linha de cima e adicionar ao array toolbarItems
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressBar = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressBar, space, refreshButton, space, goBackButton]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTappedWebsite() {
        
        let viewController = UIAlertController(title: "Open page...", message:  nil, preferredStyle: .actionSheet)
        
        for website in websites {
             viewController.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        viewController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(viewController, animated: true)
        
    }
    
    func openPage(action: UIAlertAction) {
        
        guard let actionTitle = action.title else {
            return
        }
        
        guard let newURL = URL(string: "https://www." + actionTitle) else {
            return
        }
        
        webView.load(URLRequest(url: newURL))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    //Parece não funcionar bem com domínios que não são .com.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
        showAlertBox()
    }
    
    func showAlertBox() {
        let alertView = UIAlertController(title: "Can't load web page.", message: "You are not allowed to visit that web site.", preferredStyle: .alert)
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(alertView, animated: true)
    }
}
