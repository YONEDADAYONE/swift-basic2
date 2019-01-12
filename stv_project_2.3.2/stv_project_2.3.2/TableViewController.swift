//
//  TableViewController.swift
//  stv_project_2.3.2
//
//  Created by 米田大弥 on 2019/01/02.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    //空の配列
    var todoArray: [TrTodo] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tableview.delegate = self
        tableview.dataSource = self
        fetchDate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tableview.reloadData()
        viewDidLoad()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //ここで自分で指定したCellを呼んでる。
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let formatter = DateFormatter()
        formatter.dateFormat =
            DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        print(formatter.string(from: Date()))
        let name = todoArray[indexPath.row]
        let limitDateString = formatter.string(from: name.limitDate)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy年MM月dd日"
//        formatter.locale = Locale(identifier: "ja_JP")
//        formatter.timeStyle = .none
//        let name = todoArray[indexPath.row]
//      let limitDateString = formatter.string(from: name.limitDate)
//        let date1:Date = name.limitDate
//        let  limitDateString = (formatter.string(from: date1))
        //Cellに表示する内容
        cell.textLabel!.text = "\(name.todoTitle) + \(limitDateString)"
        cell.textLabel?.lineBreakMode = .byTruncatingTail
        return cell
    }
    //スワイプで削除
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let city = todoArray[indexPath.row]
        let realm = try? Realm()
        do {
            try realm?.write {
                realm?.delete(city)
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
        _ = try? Realm()
        //空の配列のCityArrayにrelmeのデータを入れる
//        todoArray = Array(realm.objects(trTodo.self))
        return todoArray.count
    }
    //自作関数
    func fetchDate() {
        let realm = try? Realm()
        //空の配列のCityArrayにrelmeのデータを入れる
        todoArray = Array(realm!.objects(TrTodo.self).sorted(byKeyPath: "limitDate", ascending: false))
    }

}
