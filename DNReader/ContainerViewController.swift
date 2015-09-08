//
//  ContainerViewController.swift
//  DNReader
//
//  Created by Felix Hedlund on 08/09/2015.
//  Copyright (c) 2015 Tactel. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var viewController : UISplitViewController!
    
    var maximumColumnWidth: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        maximumColumnWidth = self.viewController.maximumPrimaryColumnWidth
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setEmbeddedViewController(splitViewController: UISplitViewController!){
        if splitViewController != nil{
            viewController = splitViewController
            
            self.addChildViewController(viewController)
            self.view.addSubview(viewController.view)
            viewController.didMoveToParentViewController(self)
            
            self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular), forChildViewController: viewController)
        }
    }
    
    func hideNewsTopics(){
        
        UIView.animateWithDuration(0.6, delay: 0.0, options: .CurveEaseOut | .CurveEaseIn, animations: {
            self.viewController.maximumPrimaryColumnWidth = 0
            }, completion:{(Bool)  in
        
        })
    }
    
    func showNewsTopics(){
        UIView.animateWithDuration(0.6, delay: 0.0, options: .CurveEaseOut | .CurveEaseIn, animations: {
            self.viewController.maximumPrimaryColumnWidth = self.maximumColumnWidth
            }, completion:{(Bool)  in
                
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
