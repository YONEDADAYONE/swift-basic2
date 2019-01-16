//
//  ViewController.swift
//  stv_project_2.5.5
//
//  Created by 米田大弥 on 2019/01/16.
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
    
    //https://qiita.com/toshiakiokano@github/items/92a96ad669df067de3fc を参照
    
    
    //CIFilterの導入
    @IBAction func monochromeButton(_ sender: UIButton) {
        
        let filteredImage = CIImage(image: self.cameraView.image!)
        let filter = CIFilter(name: "CIVignette")
        
        filter!.setValue(filteredImage, forKey: "inputImage")
        filter!.setValue(NSNumber(value: 9.0), forKey: "inputIntensity")
        
        
        let ciContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage((filter?.outputImage)!, from: (filter?.outputImage!.extent)!)
        let outputImage = UIImage(cgImage: imageRef!)
        self.cameraView.image = outputImage
    }
    
    
}
