//
//  ViewController.swift
//  stv_project_2.1.13
//
//  Created by 米田大弥 on 2018/12/24.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
//    let image01 = #imageLiteral(resourceName: "9")
//    let image02 = #imageLiteral(resourceName: "4")
//    let image03 = #imageLiteral(resourceName: "8")
//    let image04 = #imageLiteral(resourceName: "1")
//    let image05 = #imageLiteral(resourceName: "2")
//    let image06 = #imageLiteral(resourceName: "5")
//    let image07 = #imageLiteral(resourceName: "3")
//    let image08 = #imageLiteral(resourceName: "6")
//    let image09 = #imageLiteral(resourceName: "7")
//    let image10 = #imageLiteral(resourceName: "10")
    
    var photos = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    //セクション名
    let sectionTitle: NSArray = ["セクション1", "セクション2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    //関数
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        
//        //"Cellはストーリーボードで設定したセルのID"
        let testCell: UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        //タグ番号を使ってImageViewのインスタンス生成
        let imageView = testCell.contentView.viewWithTag(1) as? UIImageView
 
        //画像配列の番号で指定された要素の前の画像をUIimageとする。
        let cellImage = UIImage(named: photos[indexPath.row])
        imageView?.image = cellImage

        return testCell
        
    }
    
    //セクション内のセルの数を返すメソッド
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photos.count
        
        switch section {
            
        case 0:
            return photos.count
        default:
            return photos.count
            
        }
    
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTitle.count
    }
    
     //Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        //↓横と縦のスペース
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 12

        return CGSize(width: 60, height: 70)
    }
    
    // ヘッダ、フッタを設定するメソッド
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath)
        -> UICollectionReusableView {
        
        if kind == "UICollectionElementKindSectionHeader" {
            //ヘッダーの場合
            let testSection =
                collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                withReuseIdentifier: "header",
                                                                for: indexPath) as? HederCollectionReusableView
            
//            if let url: URL = URL(string: "https://www.yahoo.co.jp") {
//                let request: URLRequest = URLRequest(url: url)
//                // インスタンスをビューに追加する
//                webView.load(request)
//            }

            testSection?.testLabel.text = sectionTitle[indexPath.section] as? String
            
            return testSection ?? UICollectionReusableView()
            
        } else {
            //フッターの場合(今回は使用しない)
            let testSection =
                collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                withReuseIdentifier: "footer", for: indexPath)
    
            return testSection
            
        }
    
}
    
}
