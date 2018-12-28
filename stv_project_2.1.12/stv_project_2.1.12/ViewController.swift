//
//  ViewController.swift
//  stv_project_2.1.12
//
//  Created by 米田大弥 on 2018/12/23.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let photos = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //関数
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        
    //"Cellはストーリーボードで設定したセルのID"
        let testCell: UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    //タグ番号を使ってImageViewのインスタンス生成
        let imageView = testCell.contentView.viewWithTag(1) as? UIImageView
    //画像配列の番号で指定された要素の前の画像をUIimageとする。
        let cellImage = UIImage(named: photos[indexPath.row])
        
        imageView?.image = cellImage
        
        return testCell
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //↓横と縦のスペース
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 12
        
        return CGSize(width: 100, height: 100)
}

}
