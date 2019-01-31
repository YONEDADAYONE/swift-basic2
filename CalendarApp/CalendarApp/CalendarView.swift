//
//  CalendarView.swift
//  CalendarApp
//
//  Created by 米田大弥 on 2019/01/30.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class CalendarView: UIViewController {
    
    @IBOutlet weak var nextMonthButton: UIBarButtonItem!
    @IBOutlet weak var backMonthButton: UIBarButtonItem!
    @IBOutlet weak var headerTitle: UILabel!    //③
    @IBOutlet weak var calenderCollectionView: UICollectionView!//⑤
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    //②タップ時

    @IBAction func tappedButtonMonthButton(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func tappedNextMonthButton(_ sender: UIBarButtonItem) {
    }
}

