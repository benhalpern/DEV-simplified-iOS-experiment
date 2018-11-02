//
//  ViewController.swift
//  DEV-Simple
//
//  Created by Ben Halpern on 11/1/18.
//  Copyright © 2018 DEV. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    var lightAlpha = CGFloat(0.2)
    
    
    override func viewDidLoad() {
        webView.customUserAgent = "DEV-Native-iOS"
        webView.scrollView.scrollIndicatorInsets.top = view.safeAreaInsets.top + 50
        let url = URL(string: "https://dev.to")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: [.new, .old], context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: [.new, .old], context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: [.new, .old], context: nil)
        webView.layer.shadowColor = UIColor.gray.cgColor
        webView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        webView.layer.shadowOpacity = 0.6
        webView.layer.shadowRadius = 0.0

        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        print("back")
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        backButton.isEnabled = webView.canGoBack
        backButton.alpha = webView.canGoBack ? 1.0 : lightAlpha
        forwardButton.isEnabled = webView.canGoForward
        forwardButton.alpha = webView.canGoForward ? 1.0 : lightAlpha
        webView.scrollView.isScrollEnabled = !(webView.url?.path.hasPrefix("/connect"))!  //Remove scroll if /connect view

    }
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("finished")
//    }

}

