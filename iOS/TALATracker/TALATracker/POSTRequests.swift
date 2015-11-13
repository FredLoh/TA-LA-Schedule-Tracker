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
    let urlString = "http://myfirstphpapp-testingtojson1.rhcloud.com/"
    let getURL = NSURL(string: urlString)
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:getURL!)
    request.HTTPMethod = "POST"
    let systemVersion = UIDevice.currentDevice().systemVersion
    let bodyData = "None for now"
    request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
        
        (response, data, error) in
        
        let resStringNS = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(resStringNS)
        success()
    }
}
