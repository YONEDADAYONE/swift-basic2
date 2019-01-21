//
//  ViewController.swift
//  stv_project_2.3.2
//
//  Created by 米田大弥 on 2019/01/01.
//  Copyright © 2019 hiroya. All rights reserved.
//

import RealmSwift
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var todoTitleText: UITextField!
    @IBOutlet weak var todoContentsText: UITextField!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
                print(Realm.Configuration.defaultConfiguration.fileURL!)
         todoTitleText.delegate = self
        // デフォルトRealmを取得
        //swiftLintで指摘されたのでlet realm = try? Realm()を_ = try? Realm()に変更
        _ = try? Realm()
        button.isEnabled = false
    }
    //文字が入力されていない場合エンターキーを非活性にするメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if todoTitleText.text == "" {
            todoTitleText.enablesReturnKeyAutomatically = true
            button.isEnabled = false
        } else if todoTitleText.text != "" {
            todoTitleText.resignFirstResponder()
            button.isEnabled = true
        }
        return true
    }
    @IBAction func saveBtn(_ sender: UIButton) {
        //それぞれの箱の中にtextFieldに入力された文字をいれる
        let todoTitleTextName = self.todoTitleText!.text
        let todoContentsTextName = self.todoContentsText!.text
        //newCityの箱にクラスCityLibを継承
        let trTodoBox = TrTodo()
        //定数newCityのプロパティにsatValueの値を入れる
        //またsetValueの前は値で今回はtextの値をいれて、forKeyでは 別クラスのキーを参照している
        trTodoBox.setValue(self.todoTitleText!.text, forKey: "todoTitle")
        trTodoBox.setValue(self.todoContentsText!.text, forKey: "todoContents")
        var calendar = Calendar.current
        var compornets = DateComponents()
        compornets.year = 2019
        compornets.month = Int.random(in: 1 ... 12)
        compornets.day = Int.random(in: 1 ... 28)
        compornets.timeZone = nil
        if let date = calendar.date(from: compornets) {
            trTodoBox.limitDate = date
        }
        //プライマリーキーIDに1ずつ足す方法
        //https://qiita.com/kotala_b/items/68b9608df6c8bac80f67
        var maxId: Int? { return try? Realm().objects(TrTodo.self).sorted(byKeyPath: "todoid").last?.todoid ?? 0 }
        trTodoBox.setValue(trTodoBox.todoid + 1, forKey: "todoid")
        trTodoBox.todoid = maxId! + 1 //三項演算子の使用のため?? 0 を追加
        //デフォルトのRealmを取得
        //try! は例外を無視するという意味
        //定数realmはRealmを継承している
        let realm = try? Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        //do節でエラーを投げる可能性のあるメソッドを呼び出します。
        //tryはメソッドの呼び出し
        //catchはエラー処理
        do {
            //writeではテキストを指定したファイルに書き込むことができる。
            //ここではrealmに書き込んでいる。
            try realm?.write {
                //上で作成したnewCityの変数にデータを書き込んでいる。
                realm?.add(trTodoBox)
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
}
