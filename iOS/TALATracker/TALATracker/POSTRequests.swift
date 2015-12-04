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
import Alamofire

/// sendFirstPOST: Sends initial post to get all data from DB.
///
/// -Parameters: None
///
/// -Returns: Boolean
func sendFirstPOST(success:()->())->Bool {
    let urlString = "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php"
    guard let getURL = NSURL(string: urlString) as NSURL? else {
        return false
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
            infoArray.removeAll()
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
    return true
}
func sendClassPOST(input: String, success:()->()) {
    let parameters = [
        "type": "class",
        "phrase": "\(input)",
    ]
    print(input)
    Alamofire.request(.POST, "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php", parameters: parameters)
        .response { request, response, data, error in
            if error != nil {
                print(error)
            } else {
                if data != nil {
                    let json = JSON(data: data!)
                    timesArray.removeAll()
                    for var i=0;i<json.count;i++ {
                        guard let name = json[i]["Name"].string,
                            let className = json[i]["Classname"].string,
                            let day = json[i]["Day"].string,
                            let time = json[i]["Time"].string,
                            let location = json[i]["Location"].string else {
                                print("returning")
                                return
                        }
                        let newEntry = JSONReturn(name: name, className: className, day: day, time: time, location: location)
                        timesArray.append(newEntry)
                    }
                    print(timesArray)
                    success()
                }
            }
    }
}
