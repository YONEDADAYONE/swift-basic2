//
//  ViewController.swift
//  stv_project_2.5.2
//
//  Created by 米田大弥 on 2019/01/14.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    @IBOutlet var cameraView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // カメラの撮影開始
    @IBAction func startCamera(_ sender : AnyObject) {
        
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            print("エラー")
            
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            
            cameraView.contentMode = .scaleAspectFit
            cameraView.image = pickedImage
            
        }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        print("エラー")
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        print("エラー")
    }
    
    
    // 写真を保存
//    @IBAction func savePicture(_ sender : AnyObject) {
//        let image:UIImage! = cameraView.image
//
//        if image != nil {
//            UIImageWriteToSavedPhotosAlbum(
//                image,
//                self,
//                #selector(ViewController.image(_:didFinishSavingWithError:contextInfo:)),
//                nil)
//        }
//        else{
//           print("エラー")
//        }
//
//    }
    
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
        }
        else{
            print("成功")
        }
    }
    
//    // アルバムを表示
//    @IBAction func showAlbum(_ sender : AnyObject) {
//        let sourceType:UIImagePickerController.SourceType =
//            UIImagePickerController.SourceType.photoLibrary
//
//        if UIImagePickerController.isSourceTypeAvailable(
//            UIImagePickerController.SourceType.photoLibrary){
//            // インスタンスの作成
//            let cameraPicker = UIImagePickerController()
//            cameraPicker.sourceType = sourceType
//            cameraPicker.delegate = self
//            self.present(cameraPicker, animated: true, completion: nil)
//
//            print("save")
//        }
//        else{
//            print("エラー")
//
//        }
//
//    }
    
}
