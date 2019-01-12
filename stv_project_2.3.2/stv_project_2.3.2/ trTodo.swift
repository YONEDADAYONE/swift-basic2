//
//   trTodo.swift
//  stv_project_2.3.2
//
//  Created by 米田大弥 on 2019/01/01.
//  Copyright © 2019 hiroya. All rights reserved.
//
import Foundation
import RealmSwift

//var だけではRelme Brower で下記結果がnilになったが@objc dynamicを加えると正常になった
class TrTodo: Object {
    @objc dynamic var todoid = 0
    @objc dynamic var todoTitle = ""
    @objc dynamic var todoContents = ""
    @objc dynamic var created = Date()  //登録日
    @objc dynamic var modified = Date() //変更日
    @objc dynamic var limitDate = Date()
    @objc dynamic var deleteFlg = false
//    // idをプライマリキーに設定
    override static func primaryKey() -> String? {
        return "todoid"
    }

}
