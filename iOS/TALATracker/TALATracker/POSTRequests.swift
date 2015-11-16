//
//  POSTRequests.swift
//  TALATracker
//
//  Created by Frederik Lohner on 13/Nov/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit

func sendFirstPOST(success:()->()) {
    let urlString = "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php"
    let getURL = NSURL(string: urlString)
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:getURL!)
    request.HTTPMethod = "POST"
    /* POST format appears to be as follows, type=(type)&name=(name */
    let bodyData = "type=name&phrase=Bob"
    request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
        
        (response, data, error) in
        
//        let resStringNS = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print(resStringNS)
        print(response)
        print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        
        success()
    }
}
