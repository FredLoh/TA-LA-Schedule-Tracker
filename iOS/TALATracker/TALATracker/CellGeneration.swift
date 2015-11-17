//
//  CellGeneration.swift
//  TALATracker
//
//  Created by Frederik Lohner on 9/Nov/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

func generateInitialCell(array: NSArray, tableView: UITableView, indexPath: NSIndexPath)->UITableViewCell {
    
    let classCell = UITableViewCell(style: .Default, reuseIdentifier: "articleCell")
    let className = UILabel()
    
    classCell.addSubview(className)
    
    guard let classN = array[indexPath.row]["class"] as? String else {
        return classCell
    }
    
    className.text = classN
    dispatch_async(dispatch_get_main_queue(),{
        className.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(classCell)
        }
    })
    
    
    return classCell
}