//
//  ViewController.swift
//  stv_project_2.1.6
//
//  Created by 米田大弥 on 2018/12/21.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import Alamofire
import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet private weak var webView: WKWebView!
    let net = NetworkReachabilityManager()
    
    @IBAction func goBack(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func goForward(_ sender: UIButton) {
        webView.goForward()
    }
    
    @IBAction func reload(_ sender: UIButton) {
        webView.reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //デリゲートメソッド　これがないと表示されない
        webView.uiDelegate = self
        if let url: URL = URL(string: "https://www.google.co.jp/") {
            let request: URLRequest = URLRequest(url: url)
            // インスタンスをビューに追加する
            webView.load(request)
            chackWifi()
        }
    }
    
    //Qiita Alamofireでオフライン判定をする方法
    func chackWifi() {
        net?.startListening()
        if  net?.isReachable ?? false {
            
            if net?.isReachableOnEthernetOrWiFi != nil {
                //do some
                print("isReachableOnEthernetOrWiFi")
                
            } else if net?.isReachableOnWWAN ?? false {
                //do some
                print("isReachableOnWWAN")
                
            }
        } else {
            print("エラーです")
            
        }
    }
    
    private func webViewDidStartLoad(_ webView: WKWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private func webViewDidFinishLoad(_ webView: WKWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
