//
//  ViewController.swift
//  stv_project_2.5.4
//
//  Created by 米田大弥 on 2019/01/16.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    //写真を表示するビュー
    @IBOutlet private var cameraView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // カメラの撮影開始
    @IBAction func startCamera(_ sender: AnyObject) {
        
        let sourceType: UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera) {
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("エラー")
            
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            
            cameraView.contentMode = .scaleAspectFit
            cameraView.image = pickedImage
        }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        print("閉じます")
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        print("キャンセル")
    }

    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError?,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error?.code as Any)
        } else {
            //ここでカメラロールに移動したい
            print("成功")
        }
    }
    
    //https://picolica.com/2017/04/25/swift3-choose-from-cameraroll/ 参考
    // カメラロールから写真を選択する処理
    @IBAction func choosePicture() {
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }

}
