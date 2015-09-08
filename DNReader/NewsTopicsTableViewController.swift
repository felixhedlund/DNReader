//
//  NewsTopicsTableViewController.swift
//  DNReader
//
//  Created by Felix Hedlund on 08/09/2015.
//  Copyright (c) 2015 Tactel. All rights reserved.
//

import UIKit

struct SlideNews {
    static var urlArray: NSMutableArray!
}

class NewsTopicsTableViewController: UITableViewController, XMLParserDelegate {

    var xmlParser : XMLParser!
    @IBOutlet weak var slideshowButton: UIButton!
    var urlArray: NSArray!
    weak var parentSlideShowViewController: ParentSlideShowViewController!
    
    var hideContentView: UIView!
    var hideImage: UIImageView!
    var slideShowHasBeenShown: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideshowButton.addTarget(self, action: "slideShowPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        let url = NSURL(string: "http://www.dn.se/nyheter/m/rss/")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
        slideShowHasBeenShown = false
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func parsingWasFinished() {
        xmlParser.arrParsedData.removeAtIndex(0)
        self.tableView.reloadData()
        SlideNews.urlArray = NSMutableArray()
        for index in 0...9 {
            //SlideNews.urlArray.addObject(NSURL(fileURLWithPath: xmlParser.arrParsedData[index]["link"]!)!)
            //SlideNews.urlArray.addObject(NSURL(fileURLWithPath: xmlParser.linksArray[index] as! String)!)
            
            let dictionary = xmlParser.arrParsedData[index] as Dictionary<String, String>
            let newsLink = dictionary["link"]
            SlideNews.urlArray.addObject(newsLink!)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return xmlParser.arrParsedData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idNewsCell", forIndexPath: indexPath) as! UITableViewCell
        
        let currentDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        
        cell.textLabel?.text = currentDictionary["title"]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        let newsLink = dictionary["link"]
        
        let newsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idNewsViewController") as! NewsViewController
        
        newsViewController.newsURL = NSURL(string: newsLink!)
        newsViewController.newsDescription = dictionary["description"]
        showDetailViewController(newsViewController, sender: self)
        
    }
    
    func slideShowPressed(sender: UIButton!){
        if(slideShowHasBeenShown!){
            parentSlideShowViewController.view.hidden = false
            hideContentView.hidden = false
        }else{
            parentSlideShowViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ParentSlideShowViewController") as! ParentSlideShowViewController
        
            parentSlideShowViewController.view.setTranslatesAutoresizingMaskIntoConstraints(false)
            let container = self.parentViewController?.parentViewController?.parentViewController as! ContainerViewController
        
            container.view.addSubview(parentSlideShowViewController.view)
        
            let leadingConstraint = NSLayoutConstraint(item: parentSlideShowViewController.view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: container.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
            container.view.addConstraint(leadingConstraint)
        
            let trailingConstraint = NSLayoutConstraint(item: parentSlideShowViewController.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: container.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
            container.view.addConstraint(trailingConstraint)
        
            let topConstraint = NSLayoutConstraint(item: parentSlideShowViewController.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: container.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
            container.view.addConstraint(topConstraint)
        
            let bottomConstraint = NSLayoutConstraint(item: parentSlideShowViewController.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: container.view, attribute: NSLayoutAttribute.Bottom, multiplier: 0.5, constant: 0)
            container.view.addConstraint(bottomConstraint)
        
            addHideButton()
        }
    }
    
    func addHideButton(){
        
        let container = self.parentViewController?.parentViewController?.parentViewController as! ContainerViewController
        
        let imageWidth = Numbers.screenWidth/9
        let imageHeight = imageWidth
        let imageYPos = imageWidth
        
        hideContentView = UIView()//(frame: CGRectMake(0, imageYPos, imageWidth, imageHeight))
        hideContentView.userInteractionEnabled = true
        
        hideImage = UIImageView(frame: CGRectMake(0, 0, imageWidth, imageHeight))
        hideImage.image = UIImage(named: "Arrow-X")
        hideContentView.addSubview(hideImage)
        
        var hideButton = UIButton(frame: hideImage.frame)
        hideButton.addTarget(self, action: Selector("hideButtonPressed:"), forControlEvents: .TouchUpInside)
        
        hideContentView.addSubview(hideButton)
        
        
        self.view.addSubview(hideContentView)
        hideContentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let leadingConstraint = NSLayoutConstraint(item: hideContentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: container.view, attribute: NSLayoutAttribute.Leading, multiplier: 0.5, constant: 0)
        container.view.addConstraint(leadingConstraint)
        
        let topConstraint = NSLayoutConstraint(item: hideContentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: parentSlideShowViewController.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -imageHeight/2)
        container.view.addConstraint(topConstraint)
        
        let widthConstraint = NSLayoutConstraint (item: hideContentView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: imageWidth)
        container.view.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint (item: hideContentView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: imageHeight)
        container.view.addConstraint(heightConstraint)
        
        
        
    }
    
    func hideButtonPressed(sender: UIButton!){
        slideShowHasBeenShown = true
        parentSlideShowViewController.view.hidden = true
        hideContentView.hidden = true
        
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
