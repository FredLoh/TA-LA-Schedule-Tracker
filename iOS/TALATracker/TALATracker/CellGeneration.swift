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

func generateInitialCell(inout array: [Classes], tableView: UITableView, indexPath: NSIndexPath )->UITableViewCell {
    
    let classCell = UITableViewCell(style: .Default, reuseIdentifier: "articleCell")
    let className = UILabel()
    
    classCell.addSubview(className)
    
    guard let classN = array[indexPath.row].className else {
        return classCell
    }
    
    className.text = classN
    className.adjustsFontSizeToFitWidth = true
    className.textAlignment = .Center
    dispatch_async(dispatch_get_main_queue(),{
        className.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(classCell)
            make.left.equalTo(classCell).offset(5)
            make.right.equalTo(classCell).offset(-5)
        }
    })
    
    
    return classCell
}