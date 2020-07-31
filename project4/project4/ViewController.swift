//
//  ViewController.swift
//  project4
//
//  Created by user165519 on 5/6/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate  {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var webSites = Array<String>() // ["apple.com","google.com","yahoo.com"]
    var selectedURL = ""
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let filepath = Bundle.main.path(forResource: "urlList", ofType: "txt") {
       do {
            let contents = try String(contentsOfFile: filepath)
            //print(contents)
        for row in contents.components(separatedBy: "\n"){
            webSites.append(row)
        }
       }   catch {
        print("contents could not be loaded")
        }
       } else {
          print("urlList.txt not found!")
        }
    

        //let url = URL (string: "https:"+webSites[0])!
        //webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped2))
        
        let back=UIBarButtonItem( barButtonSystemItem: UIBarButtonItem.SystemItem.rewind, target: self, action: #selector(goBack))
        let forward=UIBarButtonItem( barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward, target: self, action: #selector(goForward))
                    
        navigationItem.leftBarButtonItems = [back,forward]
        //disBackFor()

        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        //navigationItem.leftBarButtonItem = UIBarButtonItem( barButtonSystemItem: UIBarButtonItem.SystemItem.rewind, target: self, action: #selector(goBack))

        
        progressView = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton,spacer,refresh]
        navigationController?.isToolbarHidden = false
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: NSKeyValueObservingOptions.new, context: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(viewDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear "+selectedURL)
        
        if (selectedURL.isEmpty){selectedURL = webSites[0]}
        print(selectedURL)
        let url = URL (string: "https:"+selectedURL)!
        webView.load(URLRequest(url: url))
         disBackFor()

    }
    //@objc func viewDidBecomeActive() {
    //print("viewDidBecomeActive")
    //}
    
    
    @objc func openTapped2() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Addrlist") as? AddrListTableViewController{
            vc.listSites = webSites
            vc.mainViewController = self
            navigationController?.pushViewController(vc, animated: false)
        }

    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil,preferredStyle: .actionSheet)
        for webSite in webSites {
            ac.addAction(UIAlertAction(title: webSite, style: .default, handler: openPage))
        }

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    @objc func goBack() {
        webView.goBack()
         disBackFor()
        
    }
    @objc func goForward() {
        webView.goForward()
         disBackFor()
        
    }

    func disBackFor(){
        print("call for disBlockFor")
        if(webView.canGoBack){
        self.navigationItem.leftBarButtonItems?[0].isEnabled = true;
        } else {
            self.navigationItem.leftBarButtonItems?[0].isEnabled = false;
            
        }
        if(webView.canGoForward){
        self.navigationItem.leftBarButtonItems?[1].isEnabled = true;
        } else {
            self.navigationItem.leftBarButtonItems?[1].isEnabled = false;
        }
        
    }
    

    func openPage(action: UIAlertAction) {
    let url = URL(string: "https://" + action.title!)!
    webView.load(URLRequest(url: url))
     disBackFor()

        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if (Float(webView.estimatedProgress)==1){
                print("estimatedProgress=",String(format:"%f",webView.estimatedProgress))
            disBackFor()
            }
            
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        guard let host = url?.host  else { decisionHandler(.cancel) ; return}
        
            for webSite in webSites {
                if host.contains(webSite){
                    decisionHandler(.allow)
                    return
                }
            }

        
        decisionHandler(.cancel)
               let ac = UIAlertController(title: "Error", message: "You are not allowed to go there "+host,preferredStyle: .alert)
               ac.addAction(UIAlertAction(title: "OK", style:  .default, handler: nil))
               present(ac, animated: true)
    }

    
}

