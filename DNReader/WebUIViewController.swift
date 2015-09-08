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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
    }
    
    func setContentForWebView(newsURL: String){
        webView = UIWebView(frame: CGRectMake(0, 0, Numbers.screenWidth, Numbers.screenHeight/2))
        let request : NSURLRequest = NSURLRequest(URL: NSURL(string: newsURL)!)
        webView.loadRequest(request)
        webView.hidden = false
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
