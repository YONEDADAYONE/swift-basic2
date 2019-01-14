//
//  ViewController.swift
//  stv_project_2.5.3
//
//  Created by 米田大弥 on 2019/01/15.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit
import AVFoundation

//https://i-app-tec.com/ios/avcapturestillimageoutput.htmlを参考にした。きちんと理解をすること。
class ViewController: UIViewController,
UIGestureRecognizerDelegate, AVCapturePhotoCaptureDelegate {
    
    var input:AVCaptureDeviceInput!
    var output:AVCapturePhotoOutput!
    var session:AVCaptureSession!
    
    var preView:UIView!
    var camera:AVCaptureDevice!
    
    private var photoData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面タップでシャッターを切るための設定
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(ViewController.tapped(_:)))
        // デリゲートをセット
        tapGesture.delegate = self;
        // Viewに追加.
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // スクリーン設定
        setupDisplay()
//        // カメラの設定
        setupCamera()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // camera stop メモリ解放
        session.stopRunning()
        
        for output in session.outputs {
            //session.removeOutput((output as? AVCaptureOutput)!)
            session.removeOutput(output)
        }
        
        for input in session.inputs {
            //session.removeInput((input as? AVCaptureInput)!)
            session.removeInput(input)
        }
        session = nil
        camera = nil
    }
    
    func setupDisplay(){
        //スクリーンの幅
        let screenWidth = UIScreen.main.bounds.size.width;
        //スクリーンの高さ
        let screenHeight = UIScreen.main.bounds.size.height;
        
        // プレビュー用のビューを生成
        preView = UIView(frame: CGRect(x: 0.0, y: 0.0,
                                       width: screenWidth, height: screenHeight))
        
    }
    
//    // camera initialize
    func setupCamera(){
        // セッション
        session = AVCaptureSession()

        // 背面・前面カメラの選択
        camera = AVCaptureDevice.default(
            AVCaptureDevice.DeviceType.builtInWideAngleCamera,
            for: AVMediaType.video,
            position: .back) // position: .front

        // カメラからの入力データ
        do {
            input = try AVCaptureDeviceInput(device: camera)

        } catch let error as NSError {
            print(error)
        }

        // 入力をセッションに追加
        if(session.canAddInput(input)) {
            session.addInput(input)
        }

        // 静止画出力のインスタンス生成
        output = AVCapturePhotoOutput()

        // 出力をセッションに追加
        if(session.canAddOutput(output)) {
            session.addOutput(output)
        }

        // セッションからプレビューを表示を
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)

        previewLayer.frame = preView.frame
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

        // レイヤーをViewに設定
        // これを外すとプレビューが無くなる、けれど撮影はできる
        self.view.layer.addSublayer(previewLayer)

        session.startRunning()
    }
    
    
    // タップイベント.
    @objc func tapped(_ sender: UITapGestureRecognizer){
        print("タップ")
        takeStillPicture()
    }
    
    
    func takeStillPicture(){
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = .auto
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = false
        
        output?.capturePhoto(with: photoSettings, delegate: self)
    }
    
    //    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // AVCapturePhotoOutput.jpegPhotoDataRepresentation deprecated in iOS11
        let imageData = photo.fileDataRepresentation()
        
        let photo = UIImage(data: imageData!)
        // アルバムに追加.
        UIImageWriteToSavedPhotosAlbum(photo!, self, nil, nil)
    }
    
    

}
