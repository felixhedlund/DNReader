//
//  NewsViewController.swift
//  DNReader
//
//  Created by Felix Hedlund on 08/09/2015.
//  Copyright (c) 2015 Tactel. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var newsURL : NSURL!
    var appDelegate: AppDelegate!
    var hideImage: UIImageView!
    var newsTopicsIsHidden: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTopicsIsHidden = false
        webView.hidden = true
        toolbar.hidden = true
        addHideButton()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if newsURL != nil {
            let request : NSURLRequest = NSURLRequest(URL: newsURL)
            webView.loadRequest(request)
            
            if webView.hidden {
                webView.hidden = false
                toolbar.hidden = false
            }
            
        }
    }
    
    func addHideButton(){
        
        let imageWidth = Numbers.screenWidth/9
        let imageHeight = imageWidth
        let imageYPos = imageWidth
        
        var contentView = UIView(frame: CGRectMake(0, imageYPos, imageWidth, imageHeight))
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.userInteractionEnabled = true
        
        hideImage = UIImageView(frame: CGRectMake(0, 0, imageWidth, imageHeight))
        hideImage.image = UIImage(named: "Arrow-left")
        contentView.addSubview(hideImage)
        
        var hideButton = UIButton(frame: hideImage.frame)
        hideButton.addTarget(self, action: Selector("hideButtonPressed:"), forControlEvents: .TouchUpInside)
//        hideButton.addTarget(appDelegate.containerViewController, action: "hideButtonPressed:", forControlEvents: .TouchUpInside)
        contentView.addSubview(hideButton)
        
        self.view.addSubview(contentView)
        self.view.bringSubviewToFront(contentView)
        
        let leadingConstraint = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: -imageWidth/2.5)
        self.view.addConstraint(leadingConstraint)
        
        let topConstraint = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: imageHeight*2)
        self.view.addConstraint(topConstraint)
        
        let widthConstraint = NSLayoutConstraint (item: contentView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: imageWidth)
        self.view.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint (item: contentView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: imageHeight)
        self.view.addConstraint(heightConstraint)
        
        
        
    }
    
    func hideButtonPressed(sender: UIButton!){
        if(newsTopicsIsHidden!){
            newsTopicsIsHidden = false
            hideImage.image = UIImage(named: "Arrow-left")
            appDelegate.containerViewController.showNewsTopics()
        }else{
            newsTopicsIsHidden = true
            hideImage.image = UIImage(named: "Arrow-right")
            appDelegate.containerViewController.hideNewsTopics()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func favoriteNews(sender: AnyObject) {
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
