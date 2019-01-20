//
//  ViewController.swift
//  stv_project_2.4.7
//
//  Created by 米田大弥 on 2019/01/19.
//  Copyright © 2019 hiroya. All rights reserved.
//

import TwitterCore
import TwitterKit
import UIKit

//50問課題が終了したら人に解説できるレベルまでもっていくこと
class ViewController: UIViewController, TWTRComposerViewControllerDelegate {

    //空の変数の入れ物を用意
    var imgTweet: UIImageView!
    var tvTweet: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ログイン認証
//        TWTRComposer().show(from: self) { _ in }
    }
    
    @IBAction func button(_ sender: UIButton) {
        
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            
            guard let shareImg2 = UIImage.init(named: "megane_sagasu_odeko_woman") else{
                print("メガネを探す女性")
                return
            }
            let composer = TWTRComposerViewController.init(initialText: "メガネを探す女性です。", image: shareImg2, videoURL: nil)
            composer.delegate = self
            present(composer, animated: true, completion: nil)
            
        } else {
            TWTRTwitter.sharedInstance().logIn { session, error in
                if session != nil { 
                    
                    guard let shareImg2 = UIImage.init(named: "sweets_shave_ice") else{
                        print("すごい色のアイス")
                        return
                    }
                    //let shareImg = UIImage.init(named: "mountain")!
                    let composer = TWTRComposerViewController.init(initialText: "着色料のすごいアイスです、。", image: shareImg2, videoURL: nil)
                    composer.delegate = self
                    self.present(composer, animated: true, completion: nil)
                    
                    
                } else {
                    let alert = UIAlertController(title: "Twitterアカウントがありません。", message: "アカウントを作成してください。", preferredStyle: .alert)
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
    }
    
    func composerDidCancel(_ controller: TWTRComposerViewController) {
        print("composerDidCancel, composer cancelled tweet")
    }
    
    func composerDidSucceed(_ controller: TWTRComposerViewController, with tweet: TWTRTweet) {
        print("composerDidSucceed tweet published")
    }
    func composerDidFail(_ controller: TWTRComposerViewController, withError error: Error) {
        print("composerDidFail, tweet publish failed == \(error.localizedDescription)")
    }
    
}
