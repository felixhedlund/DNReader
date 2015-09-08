//
//  WebUIView.swift
//  DNReader
//
//  Created by Felix Hedlund on 08/09/2015.
//  Copyright (c) 2015 Tactel. All rights reserved.
//

import UIKit

class WebUIViewController: UIViewController {
    var webView: UIWebView!
    var pageIndex: Int!
    var newsURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        webView.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let request : NSURLRequest = NSURLRequest(URL: NSURL(string: newsURL)!)
        webView.loadRequest(request)
    }
    
    
    
    func setContentForWebView(newsURL: String){
        self.newsURL = newsURL
        webView = UIWebView(frame: CGRectMake(0, 0, Numbers.screenWidth, Numbers.screenHeight/2))
        
        
        webView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let leadingConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        self.view.addConstraint(leadingConstraint)
        
        let trailingConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        self.view.addConstraint(trailingConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        self.view.addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        self.view.addConstraint(widthConstraint)
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
