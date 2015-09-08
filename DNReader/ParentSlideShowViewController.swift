//
//  ParentSlideShowViewController.swift
//  DNReader
//
//  Created by Felix Hedlund on 08/09/2015.
//  Copyright (c) 2015 Tactel. All rights reserved.
//

import UIKit

class ParentSlideShowViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var currentIndex = 0
    var nextIndex = 0
    
    var slideIndex = 0
    var currentView: WebUIViewController!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        self.pageTitles = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SlideShowPageViewController") as! UIPageViewController
        self.pageViewController.view.frame = CGRectMake(0, 0, Numbers.screenWidth, Numbers.screenHeight/2)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        currentView = self.viewControllerAtIndex(0) as WebUIViewController
        var viewControllers = NSArray(object: currentView)
        
        self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: true, completion: nil)
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        
        let demoTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("slideShow"), userInfo: nil, repeats: true)
        
        

    }
    
    func slideShow(){
        if(slideIndex<9){
            slideIndex += 1
        }else{
            slideIndex = 0
        }
        let currentContentViewControllerDisplayed = currentView
        
        let contentViewControllerToDisplay = self.viewControllerAtIndex(slideIndex) as WebUIViewController
        self.pageViewController.setViewControllers([contentViewControllerToDisplay],
            direction: UIPageViewControllerNavigationDirection.Forward,
            animated: true,
            completion:{(Bool)  in
                self.currentView = contentViewControllerToDisplay
        })
    }
    
    func viewControllerAtIndex(index: Int) -> WebUIViewController{
        var newIndex = index
        
        if((self.pageTitles.count == 0) || (index >= self.pageTitles.count)){
            return WebUIViewController()
        }
        var vc: WebUIViewController!
        vc = WebUIViewController()
        
        vc.setContentForWebView(SlideNews.urlArray[index] as! String)
        
        vc.pageIndex = newIndex
        
        return vc
    }
    
    //DELEGATE
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        // the page view controller is about to transition to a new page, so take note
        // of the index of the page it will display.  (We can't update our currentIndex
        // yet, because the transition might not be completed - we will check in didFinishAnimating:)
        if let itemController = pendingViewControllers[0] as? WebUIViewController {
            nextIndex = itemController.pageIndex
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if (completed) {
            // the page view controller has successfully transitioned to the next view
            // controller, so we can update our currentIndex to the value we obtained
            // in the willTransitionToViewControllers method:
            currentIndex = nextIndex
            
            let contentViewControllerToDisplay = viewControllerAtIndex(currentIndex)
            self.pageViewController.setViewControllers([contentViewControllerToDisplay],
                direction: UIPageViewControllerNavigationDirection.Forward,
                animated: true,
                completion:{(Bool)  in

            })
            
            
        }
    }
    
    // MARK: - Page view controller data source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! WebUIViewController
        var index = vc.pageIndex as Int
        
        if((index == 0) || (index == NSNotFound)){
            return nil
        }
        index--
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! WebUIViewController
        var index = vc.pageIndex as Int
        
        if(index == NSNotFound){
            return nil
        }
        
        index++
        
        if(index == self.pageTitles.count as Int){
            
            return nil
        }
        
        
        
        return self.viewControllerAtIndex(index)
        
    }

}
