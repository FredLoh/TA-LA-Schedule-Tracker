//
//  GlobalVariables.swift
//  TALATracker
//
//  Created by Frederik Lohner on 4/Oct/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation

struct JSONReturn {
    var name: String?
    var className: String?
    var day: String?
    var time: String?
    var location: String?
    
    var dateTime : String {
        get {
            return day! + " " + time!
        }
    }
}
var TestArray : NSArray = []
var infoArray = [JSONReturn]()