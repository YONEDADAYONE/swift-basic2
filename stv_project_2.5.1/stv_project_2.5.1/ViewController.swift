//
//  ViewController.swift
//  stv_project_2.5.1
//
//  Created by 米田大弥 on 2019/01/14.
//  Copyright © 2019 hiroya. All rights reserved.
//

import MessageUI
import UIKit

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //ボタンを押したらメールフォームが出てくる
    @IBAction func sendMail(_ sender: UIButton) {
        //if文がtrueだったら...
        if MFMailComposeViewController.canSendMail() {
            //定数mailでMFMailComposeViewControllerを継承
            let mail = MFMailComposeViewController()
            //デリゲート
            mail.mailComposeDelegate = self
            // 定数mailにプロパティに設定
            mail.setToRecipients(["xxx@xxx.xxx"]) // 宛先アドレス
            mail.setSubject("アプリからメール送信") // 件名
            mail.setMessageBody("ここに本文を入力してください", isHTML: false) // 本文
            present(mail, animated: true, completion: nil)
        } else {
            print("送信できません")
        }
        
    }
    
    //終了処理の追加
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("キャンセル")
        case .saved:
            print("下書き保存")
        case .sent:
            print("送信成功")
        default:
            print("送信失敗")
        }
        dismiss(animated: true, completion: nil)
    }
}
