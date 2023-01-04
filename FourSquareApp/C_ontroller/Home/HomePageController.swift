//
//  HomePageController.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit
protocol changeTheindex {
}


class HomePageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {


    var delegate1: changeTheindex?
    var currentIndex = 0
    
    var previousIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
         if let startingViewController = contentView(at: 0) {
            self.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            

         }
            
    }
    
    func goToPAge(indexIs: Int) {
        
        previousIndex = indexIs
        
            if let nextVc = contentView(at: indexIs) {
               self.setViewControllers([nextVc], direction: .forward, animated: true, completion: nil)
            }
    
        
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! HomePageVc).index

        print("index before \(index)")
        currentIndex = index
        index -= 1

        return contentView(at: index)
    }

 

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! HomePageVc).index
        print("index after \(index)")
        currentIndex = index
        index += 1

        return contentView(at: index)

    }

    func contentView(at index: Int) -> HomePageVc? {
        if index < 0 || index >= 5 {
            return nil
        }

        if let pageObj = storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageVc {
            
                pageObj.index = index
            pageObj.delegate2 = delegate1 as! sendingIndex
                print("index index : \(index)")

                return pageObj            
        }
        return nil
    }

}
