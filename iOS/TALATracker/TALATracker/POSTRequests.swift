//
//  POSTRequests.swift
//  TALATracker
//
//  Created by Frederik Lohner on 13/Nov/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

func sendFirstPOST(success:()->())->[JSONReturn] {
    let urlString = "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php"
    var infoArray = [JSONReturn]()
    guard let getURL = NSURL(string: urlString) as NSURL? else {
        return infoArray
    }
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:getURL)
    request.HTTPMethod = "POST"
    /* POST format appears to be as follows, type=(type)&name=(name */
    let bodyData = "type=class&phrase="
    request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
        
        (response, data, error) in
        
        if data != nil {
            let json = JSON(data: data!)
            for var i=0;i<json.count;i++ {
                guard let name = json[i]["Name"].string,
                    let className = json[i]["Classname"].string,
                    let day = json[i]["Day"].string,
                    let time = json[i]["Time"].string,
                    let location = json[i]["Location"].string else {
                        return
                }
                let newEntry = JSONReturn(name: name, className: className, day: day, time: time, location: location)
                infoArray.append(newEntry)
            }
        }
        success()
    }
    return infoArray
}
