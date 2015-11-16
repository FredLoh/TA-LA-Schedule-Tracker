//
//  BaseJSON.swift
//  TALATracker
//
//  Created by Frederik Lohner on 4/Oct/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit

func BaseJSONGet(success:()->()) {
    let urlString = "https://raw.githubusercontent.com/FredLoh/SoftwareEngineering3308/master/testJson.json"
    let getURL = NSURL(string: urlString)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(getURL!) {
        (data, response, error) -> Void in
        if error != nil {
            print(error?.localizedDescription)
        } else {
            guard let data = data, dataString = NSString(data: data, encoding: NSISOLatin1StringEncoding) else {
                return
            }
            guard let dataFromStringUTF = dataString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) else {
                return
            }
            //            let dataString2 = NSString(data: dataFromStringUTF!, encoding: NSUTF8StringEncoding)
            guard let jsonDict : NSMutableDictionary = try? NSJSONSerialization.JSONObjectWithData(dataFromStringUTF, options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary else {
                return
            }
            TestArray = (jsonDict["classes"] as? NSMutableArray)!
//            print(TestArray)
            success()
        }
    }
    task.resume()
}