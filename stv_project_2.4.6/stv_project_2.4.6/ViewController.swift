//
//  ViewController.swift
//  stv_project_2.4.6
//
//  Created by 米田大弥 on 2019/01/15.
//  Copyright © 2019 hiroya. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import UIKit

//http://www.cl9.info/entry/2017/07/17/173803
//https://qiita.com/palinco41kcal/items/92b64eadc54a46350d6c
//https://qiita.com/toshi4dev/items/3fa8cac1154e7b109c4d
class ViewController: UIViewController, FBSDKLoginButtonDelegate, UIImagePickerControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton() // ボタンの作成
        loginButton.center = self.view.center // 位置をcenterに設定
        loginButton.delegate = self // 認証後の処理のためにdelegateを設定
        loginButton.readPermissions = ["public_profile", "email", "user_friends"] // 欲しいデータに合わせてpermissionを設定
        self.view.addSubview(loginButton) // viewにボタンを追加
        
        //        let shareButton = FBSDKShareButton()//ボタンの作成
        //         shareButton.center = CGPoint(x: view.center.x, y: 200) // 位置をcenterに設定
        
        //        var image = UIImage(named: "sweets_shave_ice")
        //        var photo = FBSDKSharePhoto()
        //        photo.image = image
        //        photo.isUserGenerated = true
        //
        //        var content = FBSDKSharePhotoContent()
        //        content.photos = [photo]
        //
        //        shareButton.shareContent = content
        
        //        let urlImage =
        //        NSURL
        //        (string: "https://upload.wikimedia.org/wikipedia/commons/0/0e/THSR_700T_Modern_High_Speed_Train.jpg")
        //
        //        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        //        imageView.center = CGPoint(x: view.center.x, y: 200)
        //        imageView.image = UIImage(data: NSData(contentsOf: urlImage! as URL)! as Data)
        //        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        //        view.addSubview(imageView)
        
        //        let content = FBSDKShareLinkContent()
        //        content.contentTitle = "a"
        //        content.imageURL = urlImage
        
        //        let shareButton = FBSDKShareButton()
        //        shareButton.center = CGPoint(x: view.center.x, y: 500)
        //        shareButton.shareContent = content
        //        view.addSubview(shareButton)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton?,
                     didCompleteWith result: FBSDKLoginManagerLoginResult?, error: Error?) {
        print("成功")
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        
        loginManager.logIn(withReadPermissions:
            ["public_profile",
             "email",
             "user_friends"],
                           from: self) { result, error in if error != nil {
                // エラーが発生した場合
                print("Process error")
            } else if result?.isCancelled ?? true {
                // ログインをキャンセルした場合
                print("Cancelled")
            } else {
                // その他
                print("Login Succeeded")
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton?) {
        print("失敗")
    }
    
    //    @IBAction func button(_ sender: UIButton) {
    //        func imagePickerController(_ picker: UIImagePickerController,
    //    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    //            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    //
    //            let photo = FBSDKSharePhoto()
    //            photo.image = image
    //            photo.isUserGenerated = true
    //            let content = FBSDKSharePhotoContent()
    //            content.photos = [photo]
    //
    //            let dialog : FBSDKShareDialog = FBSDKShareDialog()
    //            dialog.fromViewController = self
    //            dialog.shareContent = content
    //            dialog.mode = FBSDKShareDialogMode.feedWeb
    //            dialog.show()
    //
    //            print(image)
    //            print(photo)
    //            print(dialog)
    //
    //    }
    
    //    private func getShareLinkContent(objectURL: NSURL) -> FBSDKSharingContent {
    //        let content = FBSDKShareLinkContent()
    //        content.contentURL = objectURL as URL
    //        return content
    //    }
    
    //http://cocoamix.jp/archives/5329を参考にした。
    
    //今後はhttps://qiita.com/homyu/items/fa09ffb53ff7048c5365も参考になりそう。
    
    //今後はhttps://qiita.com/akatsuki174/items/5f8b703b1fb9797e8710も参考になりそう2。
    
    //今後はhttp://blue-bear.jp/kb/swift-facebooksdk%E3%81%A7%E3%82%A2%E3%83%97%E3%83%AA%E3%81%8B%E3%82%89%E7%
    //9B%B4%E6%8E%A5facebook%E6%8A%95%E7%A8%BF%E3%82%92%E8%A1%8C%E3%81%86/も参考になりそう3。
    
    //今後はhttp://rayc5.hatenablog.com/entry/2015/08/27/043556も参考になりそう4。
    
    //50問課題終了したらhttp://rayc5.hatenablog.com/entry/2015/08/27/043556やりたい。
    
    @IBAction func aaaaaa(_ sender: Any) {
        
        let photo = FBSDKSharePhoto()
        photo.image = #imageLiteral(resourceName: "sweets_shave_ice.png")
        
        photo.isUserGenerated = true
        let content = FBSDKSharePhotoContent()
        content.photos = [photo]
        
        FBSDKShareDialog.show(from: self, with: content, delegate: nil)
    }
    
}
