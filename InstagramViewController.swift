//
//  InstagramViewController.swift
//  Instagram
//
//  Created by Salyards, Adey on 11/29/15.
//  Copyright © 2015 Salyards, Adey. All rights reserved.
//

import UIKit
import AFNetworking

class InstagramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var photos: [NSDictionary]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos = []
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let url = NSURL(string: "https://api.instagram.com/v1/media/search?lat=48.858844&lng=2.294351&client_id=5857a2b7d7f54b60b273790c7d94236d")!
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            
            self.photos = dictionary["data"] as! [NSDictionary]
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PhotoCell
        
        let photo = photos[indexPath.row]
        
        let urlString = photo.valueForKeyPath("images.low_resolution.url") as! String
        
        cell.photoImageView.setImageWithURL(NSURL(string: urlString)!)
        
        return cell
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
