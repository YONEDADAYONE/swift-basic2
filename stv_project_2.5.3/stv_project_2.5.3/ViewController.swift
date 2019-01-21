//
//  ViewController.swift
//  stv_project_2.5.3
//
//  Created by 米田大弥 on 2019/01/15.
//  Copyright © 2019 hiroya. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController : UIViewController,AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak private var imageView: UIImageView!
    
    @IBOutlet weak private var cameraView: UIImageView!
    
    var captureSesssion: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    //    ↑ 書き換え AVCaptureStillImageOutput → AVCapturePhotoOutput
    
    @IBAction func takePhoto(_ sender: Any){
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.flashMode = .auto
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: self)
        imageView.contentMode = .scaleAspectFit
    }
    //    AVCapturePhotoSettingsという新しいClassがAVCapturePhotoOutputと一緒に追加された。
    //    フラッシュなどの細かい設定はAVCapturePhotoSettingsで行う
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSesssion = AVCaptureSession()
        captureSesssion.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        stillImageOutput = AVCapturePhotoOutput()
        
        let device = AVCaptureDevice.default(for: .video)
        do {
            let input = try AVCaptureDeviceInput(device: device!)
            if (captureSesssion.canAddInput(input)) {
                captureSesssion.addInput(input)
                if (captureSesssion.canAddOutput(stillImageOutput)) {
                    captureSesssion.addOutput(stillImageOutput)
                    captureSesssion.startRunning()
                    let captureVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSesssion)
                    captureVideoLayer.frame = self.imageView.bounds
                    captureVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                    self.imageView.layer.addSublayer(captureVideoLayer)
                    
                }
            }
        }
        catch {
            print(error)
        }
    }

    //デリゲート。カメラで撮影が完了した後呼ばれる。JPEG形式でフォトライブラリに保存。
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // AVCapturePhotoOutput.jpegPhotoDataRepresentation deprecated in iOS11
        let imageData = photo.fileDataRepresentation()

        let photo = UIImage(data: imageData!)
        // アルバムに追加.
        UIImageWriteToSavedPhotosAlbum(photo!, self, nil, nil)

        //ここで写真をimageViewに貼る
        cameraView.image = photo
    }
    
}
