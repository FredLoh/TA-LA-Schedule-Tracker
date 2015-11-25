////
////  BaseJSON.swift
////  TALATracker
////
////  Created by Frederik Lohner on 4/Oct/15.
////  Copyright © 2015 CSCI3308. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Alamofire
//func BaseJSONGet(success:()->()) {
//    let url = 
//    Alamofire.request(.GET, url).validate().responseJSON { response in
//        switch response.result {
//        case .Success:
//            if let value = response.result.value {
//                let json = JSON(value)
//                print("JSON: \(json)")
//            }
//        case .Failure(let error):
//            print(error)
//        }
//    }}