//
//  DBmodel.swift
//  stv_project_2.4.5
//
//  Created by 米田大弥 on 2019/01/25.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation

//プロトコルでは外部へのインターフェースのみを定義する。
//今回の場合どのクラスでも「didChange」を呼び出して使えるということ。

//これを宣言する意味は他クラスにも追加の機能を与えたいから
protocol MVCModelDelegate {
    func didChange()
}


//ここではまさにクラスの公式を使っている
// class クラス名 {
// プロパティ宣言
// メソッド宣言
// }

//プロパティと言っているが変数定数のことである。

class MVCModel {
    //public: 同じモジュール内だけでなく、別のモジュールからでもアクセスできる
    //ここではcountを0にしている。
    public var count = 0;
    //変数delegateに上記で作成した、MVCModelDelegateくクラスを継承
    var delegate: MVCModelDelegate? = nil
    
    //データの変更用メソッドを定義
    func inc() {
        count += 1
        //プロパティdelegateにプロトコルを継承
        delegate?.didChange()
    }
    
    func dec() {
        count -= 1
        //プロパティdelegateにプロトコルを継承
        delegate?.didChange()
    }
}

