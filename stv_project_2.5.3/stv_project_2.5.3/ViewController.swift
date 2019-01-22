//
//  ViewController.swift
//  stv_project_2.5.3
//
//  Created by 米田大弥 on 2019/01/15.
//  Copyright © 2019 hiroya. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak private var imageView: UIImageView?
    @IBOutlet weak private var cameraView: UIImageView?
    
    var captureSesssion: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    //    ↑ 書き換え AVCaptureStillImageOutput → AVCapturePhotoOutput
    
    @IBAction func takePhoto(_ sender: Any) {
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.flashMode = .auto
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: self)
        imageView?.contentMode = .scaleAspectFit
    }
    //    AVCapturePhotoSettingsという新しいClassがAVCapturePhotoOutputと一緒に追加された。
    //    フラッシュなどの細かい設定はAVCapturePhotoSettingsで行う
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSesssion = AVCaptureSession()
        captureSesssion?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        stillImageOutput = AVCapturePhotoOutput()
        
        guard let device = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            
            // 入力
            if captureSesssion?.canAddInput(input) ?? true {
                captureSesssion?.addInput(input)
                
                // 出力
                if captureSesssion?.canAddOutput(stillImageOutput ?? AVCapturePhotoOutput()) ?? true {
                    captureSesssion?.addOutput(stillImageOutput ?? AVCapturePhotoOutput())
                    captureSesssion?.startRunning() // カメラ起動
                    
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSesssion ?? AVCaptureSession())
                    previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect // アスペクトフィット
                    previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait // カメラの向き
                    
                    cameraView?.layer.addSublayer(previewLayer ?? AVCaptureVideoPreviewLayer())
                    
//                    // ビューのサイズの調整
                    previewLayer?.position =
                        CGPoint(x: (self.cameraView?.frame.width) ?? CGFloat() / 2,
                                y: (self.cameraView?.frame.height) ?? CGFloat() / 2)
                    previewLayer?.bounds = (cameraView?.frame) ?? CGRect()
                }
            }
         } catch {
            print(error)
        }
    }
    
    //デリゲート。カメラで撮影が完了した後呼ばれる。JPEG形式でフォトライブラリに保存。
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // AVCapturePhotoOutput.jpegPhotoDataRepresentation deprecated in iOS11
        let imageData = photo.fileDataRepresentation()
        
        let photo = UIImage(data: imageData ?? Data())
        // アルバムに追加.
        UIImageWriteToSavedPhotosAlbum(photo ?? UIImage(), self, nil, nil)
        
        //ここで写真をimageViewに貼る
        cameraView?.image = photo
    }
    
    @IBAction func monochrome(_ sender: UIButton) {
        
        //CIFilterの導入
        
        let filteredImage = CIImage(image: self.cameraView?.image ?? UIImage())
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
            self.cameraView?.image = outputImage
        }
    }
    
}
