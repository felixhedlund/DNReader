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
    @IBOutlet weak var textSwitch: UISwitch!
    @IBOutlet weak var textView: UITextView!
    
    var newsURL : NSURL!
    var newsDescription: String!
    var appDelegate: AppDelegate!
    var hideContentView: UIView!
    var hideImage: UIImageView!
    var newsTopicsIsHidden: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTopicsIsHidden = false
        webView.hidden = true
        toolbar.hidden = true
        textView.hidden = true
        addHideButton()
        setTextViewSettings()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        textSwitch.addTarget(self, action: Selector("textSwitchClicked:"), forControlEvents: UIControlEvents.ValueChanged)
        textSwitch.setOn(SavedState.textOnly, animated: false)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.bringSubviewToFront(hideContentView)
        
        if(!textSwitch.on){
            showWebContent()
        }else{
            showTextContent()
        }
    }
    
    func setTextViewSettings(){
        textView.userInteractionEnabled = false
        textView.font = UIFont(name: "ArialMT", size: 25)
    }
    
    func addHideButton(){
        
        let imageWidth = Numbers.screenWidth/9
        let imageHeight = imageWidth
        let imageYPos = imageWidth
        
        hideContentView = UIView(frame: CGRectMake(0, imageYPos, imageWidth, imageHeight))
        hideContentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        hideContentView.userInteractionEnabled = true
        
        hideImage = UIImageView(frame: CGRectMake(0, 0, imageWidth, imageHeight))
        hideImage.image = UIImage(named: "Arrow-left")
        hideContentView.addSubview(hideImage)
        
        var hideButton = UIButton(frame: hideImage.frame)
        hideButton.addTarget(self, action: Selector("hideButtonPressed:"), forControlEvents: .TouchUpInside)
//        hideButton.addTarget(appDelegate.containerViewController, action: "hideButtonPressed:", forControlEvents: .TouchUpInside)
        hideContentView.addSubview(hideButton)
        
        self.view.addSubview(hideContentView)
        
        let leadingConstraint = NSLayoutConstraint(item: hideContentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: -imageWidth/2.5)
        self.view.addConstraint(leadingConstraint)
        
        let topConstraint = NSLayoutConstraint(item: hideContentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: imageHeight*2)
        self.view.addConstraint(topConstraint)
        
        let widthConstraint = NSLayoutConstraint (item: hideContentView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: imageWidth)
        self.view.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint (item: hideContentView,
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
    
    func textSwitchClicked(sender: UISwitch) {
        if textSwitch.on {
            SavedState.textOnly = true
            showTextContent()
        } else {
            SavedState.textOnly = false
            showWebContent()
        }
    }
    
    func showWebContent(){
        if newsURL != nil {
            let request : NSURLRequest = NSURLRequest(URL: newsURL)
            webView.loadRequest(request)
            
            if webView.hidden {
                webView.hidden = false
                toolbar.hidden = false
                textView.hidden = true
            }
            
        }
    }
    
    func showTextContent(){
        if newsURL != nil {
            textView.text = newsDescription
            
            if textView.hidden {
                webView.hidden = true
                toolbar.hidden = false
                textView.hidden = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
