//
//  PetitionDetailsViewController.swift
//  White House Petitions
//
//  Created by Tomás Santiago on 19/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit
import WebKit

class PetitionDetailsViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var item: Petition? //Vai ser passado a partir do view controller principal.
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Verifica que o item que recebe não é nulo.
        guard let detailItem = item else {
            return
        }
        
        // """ = multiline string.
        //HTML para mostar a petição.
        let htmlContent = """
            <html>
            <head>
            <meta name="viewPort" content="width=device-width, initial-scale=1">
            <style> body { font-size: 150%; } </style>
            </head>
            <h4>\(detailItem.title)</h4>
            <br>
            <body>
            \(detailItem.body)
            </body>
            </html>
        """
        
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
