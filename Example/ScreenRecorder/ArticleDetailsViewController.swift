//
//  ArticleDetailsViewController.swift
//  ScreenRecorder_Example
//
//  Created by Mikayel Aghasyan on 4/6/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class ArticleDetailsViewController: UIViewController {
    var article: JSON!

    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.article["title"].string
        if let url = self.article["url"].string {
            self.webView.load(URLRequest(url: URL(string: url)!))
        }
    }
}
