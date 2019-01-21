//
//  ViewController.swift
//  stv_project_2.5.2
//
//  Created by 米田大弥 on 2019/01/14.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
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
        print("エラー")
    }
    
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError?,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error?.code as Any)
            print("書き込み失敗")
        } else {
            print("書き込み成功")
        }
    }
    
    @IBAction func monochromeButton(_ sender: UIButton) {
        //CIFilterの導入
        
        let filteredImage = CIImage(image: self.cameraView.image ?? UIImage())
            let filter = CIFilter(name: "CIVignette")
            
            filter?.setValue(filteredImage, forKey: "inputImage")
            filter?.setValue(NSNumber(value: 9.0), forKey: "inputIntensity")
        
            let ciContext = CIContext(options: nil)
        
        guard let imageRef = ciContext.createCGImage((filter?.outputImage ?? CIImage()),
                                                     from: (filter?.outputImage?.extent ?? CGRect())) else {
            return
        }
        //空の配列todoArrayにrelmeのデータを入れてフィルターをかける
        
        do {
            let outputImage = UIImage(cgImage: imageRef)
            self.cameraView.image = outputImage
        }
        
        }
}
