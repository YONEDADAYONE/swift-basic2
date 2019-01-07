//
//  ViewController.swift
//  stv_project_2.3.2
//
//  Created by 米田大弥 on 2019/01/01.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var todoTitleText: UITextField!
    @IBOutlet weak var todoContentsText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
                print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // デフォルトRealmを取得
        let realm = try! Realm()
    }
    

    @IBAction func saveBtn(_ sender: UIButton) {
        //それぞれの箱の中にtextFieldに入力された文字をいれる
        let todoTitleTextName = self.todoTitleText!.text
        let todoContentsTextName = self.todoContentsText!.text
        
        //newCityの箱にクラスCityLibを継承
        let trTodoBox = trTodo()
        //定数newCityのプロパティにsatValueの値を入れる
        //またsetValueの前は値で今回はtextの値をいれて、forKeyでは 別クラスのキーを参照している
        trTodoBox.setValue(self.todoTitleText!.text, forKey: "todoTitle")
        trTodoBox.setValue(self.todoContentsText!.text, forKey: "todoContents")
        
        
        var calendar = Calendar.current
        var compornets = DateComponents()
        compornets.year = 2019
        compornets.month = Int.random(in: 1 ... 12)
        compornets.day = Int.random(in: 1 ... 28)
        
        let date = calendar.date(from: compornets)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ja_JP")
        let str2 = formatter.string(from: date!)
        
//        print(str2)
        
        trTodoBox.setValue(str2, forKey: "limitDate")
        
        
//        trTodoBox.setValue(trTodoBox.todoid + 1, forKey: "todoid")
        
//        for todoid in todoTitleTextName! {
//
//        }
        
        //プライマリーキーIDに1ずつ足す方法
        //https://qiita.com/kotala_b/items/68b9608df6c8bac80f67
        
        var maxId: Int { return try! Realm().objects(trTodo.self).sorted(byKeyPath: "todoid").last?.todoid ?? 0 }
            
        trTodoBox.setValue(trTodoBox.todoid + 1, forKey: "todoid")
        
        trTodoBox.todoid = maxId + 1
        
        //デフォルトのRealmを取得
        //try! は例外を無視するという意味
        //定数realmはRealmを継承している
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        

        
        
        //do節でエラーを投げる可能性のあるメソッドを呼び出します。
        //tryはメソッドの呼び出し
        //catchはエラー処理
        do {
            //writeではテキストを指定したファイルに書き込むことができる。
            //ここではrealmに書き込んでいる。
            try realm.write {
                
                //上で作成したnewCityの変数にデータを書き込んでいる。
                realm.add(trTodoBox)
//                print("Added\(trTodoBox.todoTitle) to Realm DataBase")

                
                
                //書き込んだので初期化してる
                self.todoTitleText!.text = ""
                self.todoContentsText!.text = ""
                
                //登録画面に戻る
                self.dismiss(animated: true, completion: nil)
            }
        } catch {
            print(error)
        }
        
    }
    
//    //初期画面で今日の日付をに表示する、メソッド
//    func getCurrentDateTime() {
//
//        var calendar = Calendar.current
//        var compornets = DateComponents()
//        compornets.year = 2019
//        compornets.month = Int.random(in: 1 ... 12)
//        compornets.day = Int.random(in: 1 ... 28)
//
//        let date = calendar.date(from: compornets)
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.dateStyle = .long
//        formatter.locale = Locale(identifier: "ja_JP")
//        let str2 = formatter.string(from: date!)
//
//        print(str2)
//
//        trTodoBox.setValue(str2, forKey: "todoContents")
//
//    }
    
    

    
}
