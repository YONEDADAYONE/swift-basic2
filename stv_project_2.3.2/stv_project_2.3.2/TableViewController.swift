//
//  TableViewController.swift
//  stv_project_2.3.2
//
//  Created by 米田大弥 on 2019/01/02.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    //空の配列
    var todoArray:[trTodo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        fetchDate()
        tableview.reloadData()
        

        sort()
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //ここで自分で指定したCellを呼んでる。
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell" ,for: indexPath)
        //
        let name = todoArray[indexPath.row]
        //Cellに表示する内容
        cell.textLabel!.text = name.todoTitle + name.limitDate

        return cell
    }
    
    //スワイプで削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let city = todoArray[indexPath.row]
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.delete(city)
                todoArray.remove(at: indexPath.row)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        
        //空の配列のCityArrayにrelmeのデータを入れる
        todoArray = Array(realm.objects(trTodo.self))
        
        return todoArray.count
    }
    
    
    //自作関数
    func fetchDate() {
        let realm = try! Realm()
        
        //空の配列のCityArrayにrelmeのデータを入れる
        todoArray = Array(realm.objects(trTodo.self))
        
    }

    //http://swift.hiros-dot.net/?p=632#sort
    //自作関数
    func sort() {
        
        // (1)Realmのインスタンスを生成する
        let realm = try! Realm()
        // (2)全データの取得
        var results = realm.objects(trTodo.self)
        // (3)取得データの確認
        print(results)
        
        results = realm.objects(trTodo.self).sorted(byKeyPath: "limitDate", ascending: false)

    }

}
