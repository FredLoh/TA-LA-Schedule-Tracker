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
    let bodyData = "type=getClasses&phrase1=&phrase2="
    request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
        (response, data, error) in
        if error != nil {
            print(error)
        }
        if data != nil {
            let json = JSON(data: data!)
            classesArray.removeAll()
            for var i=0;i<json.count;i++ {
                guard let name = json[i]["Classname"].string else {
                    print("Error while parsing first POST")
                    return
                }
                let newEntry = Classes(className: name)
                classesArray.append(newEntry)
            }
        }
        success()
    }
    return true
}
func sendClassPOST(input: String, success:()->()) {
    let parameters = [
        "type": "ClassTAs",
        "phrase1": "\(input)",
        "phrase2": "",
    ]
    Alamofire.request(.POST, "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php", parameters: parameters)
        .response { request, response, data, error in
            if error != nil {
                print(error)
            } else {
                if data != nil {
                    let json = JSON(data: data!)
                    TAArray.removeAll()
                    for var i=0;i<json.count;i++ {
                        guard let name = json[i]["Name"].string else {
                            print("returning")
                            return
                        }
                        let newEntry = TAS(name: name)
                        TAArray.append(newEntry)
                    }
                    success()
                }
            }
    }
}

func sendSessionsPOST(classID: String, taName: String, success:()->()) {
    let parameters = [
        "type": "getSessions",
        "phrase1": "\(taName)",
        "phrase2": "\(classID)",
    ]
    Alamofire.request(.POST, "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php", parameters: parameters)
        .response { request, response, data, error in
            if error != nil {
                print(error)
            } else {
                if data != nil {
                    let json = JSON(data: data!)
                    sessionArray.removeAll()
                    for var i=0;i<json.count;i++ {
                        guard let name = json[i]["Name"].string,
                            let className = json[i]["Classname"].string,
                            let day = json[i]["Day"].string,
                            let time = json[i]["Time"].string,
                            let location = json[i]["Location"].string else {
                                print("returning")
                                return
                        }
                        let newEntry = Session(name: name, className: className, day: day, time: time, location: location)
                        sessionArray.append(newEntry)
                    }
                    success()
                }
            }
    }
}

func getTAListPOST(success:()->()) {
    let parameters = [
        "type": "ClassTAs",
        "phrase1": "",
        "phrase2": "",
    ]
    Alamofire.request(.POST, "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php", parameters: parameters)
        .response { request, response, data, error in
            if error != nil {
                print(error)
            } else {
                if data != nil {
                    let json = JSON(data: data!)
                    TAArray.removeAll()
                    for var i=0;i<json.count;i++ {
                        guard let name = json[i]["Name"].string else {
                                print("returning")
                                return
                        }
                        let newEntry = TAS(name: name)
                        TAArray.append(newEntry)
                    }
                    success()
                }
            }
    }
    
}

func getClassListFromTA(taName:String, success:()->()) {
    let parameters = [
        "type": "TAsClasses",
        "phrase1": "\(taName)",
        "phrase2": "",
    ]
    Alamofire.request(.POST, "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php", parameters: parameters)
        .response { request, response, data, error in
            if error != nil {
                print(error)
            } else {
                if data != nil {
                    let json = JSON(data: data!)
                    classesArray.removeAll()
                    for var i=0;i<json.count;i++ {
                        guard let className = json[i]["Classname"].string else {
                            print("returning")
                            return
                        }
                        let newEntry = Classes(className: className)
                        classesArray.append(newEntry)
                    }
                    success()
                }
            }
    }
}

//ADD TA POST
//Add test individually first
//Then name, className, day, time, location

func addClass(name: String, className: String, days: String, times: String, location: String, success:()->()) {
    let parameters = [
        "type": "addSession",
        "phrase1": "\(name)",
        "phrase2": "\(className)",
        "phrase3": "\(days)",
        "phrase4": "\(times)",
        "phrase5": "\(location)",
    ]
    let parameters2 = [
        "type": "addTA",
        "phrase1": "\(name)",
    ]
    Alamofire.request(.POST, "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php", parameters: parameters2)
        .response { request, response, data, error in
            if error != nil {
                print(error)
            } else {
                if data != nil {
                }
            }
    }
    Alamofire.request(.POST, "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php", parameters: parameters)
        .response { request, response, data, error in
            if error != nil {
                print(error)
            } else {
                if data != nil {
                    success()
                }
            }
    }
}