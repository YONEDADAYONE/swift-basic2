//
//  PageViewController.swift
//  stv_project_2.1.16
//
//  Created by 米田大弥 on 2018/12/23.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst() ?? UIViewController()],
                                direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    func getFirst() -> ViewController1? {
        return (storyboard?.instantiateViewController(withIdentifier: "ViewController1") as? ViewController1)
    }
    
    func getSecond() -> ViewController2? {
        return (storyboard?.instantiateViewController(withIdentifier: "ViewController2") as? ViewController2)
    }
    
    func getThird() -> ViewController3? {
        return (storyboard?.instantiateViewController(withIdentifier: "ViewController3") as? ViewController3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: ViewController3.self) {
            // 3 -> 2
            return getSecond()
        } else if viewController.isKind(of: ViewController2.self) {
            // 2 -> 1
            return getFirst()
        } else {
            // 1 -> end of the road
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: ViewController1.self) {
            // 1 -> 2
            return getSecond()
        } else if viewController.isKind(of: ViewController2.self) {
            // 2 -> 3
            return getThird()
        } else {
            // 3 -> end of the road
            return nil
        }
    }
}
