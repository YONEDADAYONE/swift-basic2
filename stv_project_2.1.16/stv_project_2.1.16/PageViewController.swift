//
//  PageViewController.swift
//  stv_project_2.1.16
//
//  Created by 米田大弥 on 2018/12/23.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    lazy var subViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ViewController1") as? ViewController1,
            UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ViewController2") as? ViewController2,
            UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ViewController3") as? ViewController3
        ]
        }() as? [UIViewController] ?? [UIViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    //デリゲートメソッド
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
    return subViewControllers[currentIndex - 1]
    }
    
    //デリゲートメソッド
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count {
            return nil
        }
    return subViewControllers[currentIndex + 1]
}

}
