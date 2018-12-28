//
//  ViewController.swift
//  stv_project_1.1.5
//
//  Created by 米田大弥 on 2018/12/21.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let favoriteProgrammingLanguage = FavoriteProgrammingLanguage()
        let account = Account()
        favoriteProgrammingLanguage.delegate = account
        favoriteProgrammingLanguage.languagege()
    }

}
