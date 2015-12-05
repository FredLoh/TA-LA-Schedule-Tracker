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
                print(classesArray)
                print(classesArray.count)
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
    print(input)
    Alamofire.request(.POST, "http://myfirstphpapp-testingtojson1.rhcloud.com/to_json.php", parameters: parameters)
        .response { request, response, data, error in
            if error != nil {
                print(error)
            } else {
                if data != nil {
                    let json = JSON(data: data!)
                    print(json)
                    TAArray.removeAll()
                    for var i=0;i<json.count;i++ {
                        guard let name = json[i]["Name"].string else {
                            print("returning")
                            return
                        }
                        let newEntry = TAS(name: name)
                        print(newEntry)
                        TAArray.append(newEntry)
                    }
                    print(TAArray)
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
                    print(json)
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
                        print(newEntry)
                        sessionArray.append(newEntry)
                    }
                    print(sessionArray)
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
                    print(json)
                    TAArray.removeAll()
                    for var i=0;i<json.count;i++ {
                        guard let name = json[i]["Name"].string else {
                                print("returning")
                                return
                        }
                        let newEntry = TAS(name: name)
                        print(newEntry)
                        TAArray.append(newEntry)
                    }
                    print(TAArray)
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
                    print(json)
                    classesArray.removeAll()
                    for var i=0;i<json.count;i++ {
                        guard let className = json[i]["Classname"].string else {
                            print("returning")
                            return
                        }
                        let newEntry = Classes(className: className)
                        print(newEntry)
                        classesArray.append(newEntry)
                    }
                    print(classesArray)
                    success()
                }
            }
    }
}

//ADD TA POST
//Add test individually first
//Then name, className, day, time, location

func addClass(success:()->()) {
    let parameters = [
        "type": "addSession",
        "phrase1": "Test",
        "phrase2": "CSCI 2270: Computer Science 2: Data Structures",
        "phrase3": "M.T.W.T.F",
        "phrase4": "11:00 AM - 8:00 PM",
        "phrase5": "CSEL",
    ]
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