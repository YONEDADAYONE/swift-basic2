//
//  Cachemodel.swift
//  stv_project_2.4.5
//
//  Created by 米田大弥 on 2019/01/27.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation

class Cachemodel {
    
    //まず入れ物を用意します
    //NSCacheのインスタンスを生成しておく。ここに、どんどんキャッシュ化されたものが保存されていく。
    let imageCache = NSCache<AnyObject, AnyObject>()
    
}
