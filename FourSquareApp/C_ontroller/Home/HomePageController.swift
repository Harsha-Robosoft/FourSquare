//
//  HomePageController.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit
protocol changeTheindex {
    func indexToChange(index: Int)
}


class HomePageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {


    var delegate1: changeTheindex?
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
         if let startingViewController = contentView(at: 0) {
            self.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            

         }
            
    }
    
    func goToPAge(indexIs: Int) {
        
        if let nextVc = contentView(at: indexIs) {
           self.setViewControllers([nextVc], direction: .forward, animated: true, completion: nil)
       }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! HomePageViewController).index
        delegate1?.indexToChange(index: index)

        currentIndex = index
        index -= 1

        return contentView(at: index)
    }

 

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! HomePageViewController).index
        delegate1?.indexToChange(index: index)

        currentIndex = index
        index += 1

        return contentView(at: index)

    }

    func contentView(at index: Int) -> HomePageViewController? {
        if index < 0 || index >= 5 {
            return nil
        }

        if let pageObj = storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
            pageObj.index = index
            return pageObj
        }
        return nil
    }

}
