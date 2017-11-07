//
//  ContestPageViewController.swift
//  THPTMath
//
//  Created by hung le on 11/5/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit

protocol ContestPageViewControllerDelegate: class
{
    func setupPageController(numberOfPages: Int)
    func turnPageController(to index: Int)
}

class ContestPageViewController: UIPageViewController {
    
    var jsStrings: [String]?
    weak var contestPageViewController: ContestPageViewControllerDelegate?
    
    lazy var controllers: [ContestCurrentViewController] = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var controllers = [ContestCurrentViewController]()
        
        if let jsStrings = self.jsStrings {
            for jsString in jsStrings {
                let contestVC = storyboard.instantiateViewController(withIdentifier: "ContestCurrentViewController") as? ContestCurrentViewController
                contestVC?.jsString = jsString
                controllers.append(contestVC!)
            }
        }
        
        self.contestPageViewController?.setupPageController(numberOfPages: controllers.count)
        
        return controllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        dataSource = self
        delegate = self
        
        self.turnToPage(index: 0)
    }
    
    func turnToPage(index: Int)
    {
        if(controllers.count > 0){
            let controller = controllers[index]
            var direction = UIPageViewControllerNavigationDirection.forward
            
            if let currentVC = viewControllers?.first {
                let currentIndex = controllers.index(of: currentVC as! ContestCurrentViewController)!
                if currentIndex > index {
                    direction = .reverse
                }
            }
            
            self.configureDisplaying(viewController: controller)
            
            setViewControllers([controller], direction: direction, animated: true, completion: nil)
        }
    }
    
    func configureDisplaying(viewController: UIViewController)
    {
        for (index, vc) in controllers.enumerated() {
            if viewController === vc {
                //if let contestVC = viewController as? ContestCurrentViewController {
                if viewController is ContestCurrentViewController {
                    //contestVC.jsString = self.jsStrings?[index]
                    self.contestPageViewController?.turnPageController(to: index)
                }
            }
        }
    }
}

extension ContestPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        if let index = controllers.index(of: viewController as! ContestCurrentViewController) {
            if index > 0 {
                return controllers[index-1]
            }
        }
        
        //return controllers.first
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        if let index = controllers.index(of: viewController as! ContestCurrentViewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            }
        }
        
        return nil
    }
}

extension ContestPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController])
    {
        self.configureDisplaying(viewController: pendingViewControllers.first as! ContestCurrentViewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if !completed {
            self.configureDisplaying(viewController: previousViewControllers.first as! ContestCurrentViewController)
        }
    }
}
