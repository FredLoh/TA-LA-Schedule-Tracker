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
    let separatorBar = UIView()
    let imageView = UIImageView()
    
    classCell.addSubview(imageView)
    classCell.addSubview(separatorBar)
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
            make.left.equalTo(imageView.snp_right).offset(5)
            make.right.equalTo(classCell).offset(-5)
        }
    })
    imageView.snp_makeConstraints { (make) -> Void in
        make.centerY.equalTo(classCell)
        make.left.equalTo(classCell).offset(5)
        make.height.width.equalTo(30)
    }
    imageView.image = UIImage(named: "bigBuff")
    
    separatorBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.15)
    separatorBar.snp_makeConstraints { (make) -> Void in
        make.left.bottom.right.equalTo(classCell)
        make.height.equalTo(0.5)
    }
    
    switch classN[5...8] {
    case "1300":
        imageView.image = UIImage(named: "1300")
    case "2270":
        imageView.image = UIImage(named: "2270")
    case "2400":
        imageView.image = UIImage(named: "2400")
    case "3104":
        imageView.image = UIImage(named: "3104")
    case "3155":
        imageView.image = UIImage(named: "3155")
    case "3308":
        imageView.image = UIImage(named: "3308")
    case "3753":
        imageView.image = UIImage(named: "3753")
    default:
        print("None")
    }
    
    return classCell
}

func generateTALACell(inout array: [TAS], tableView: UITableView, indexPath: NSIndexPath )->UITableViewCell {
    
    let talaCell = UITableViewCell(style: .Default, reuseIdentifier: "talaCell")
    let className = UILabel()
    let separatorBar = UIView()
    
    talaCell.addSubview(separatorBar)
    talaCell.addSubview(className)
    
    guard let classN = array[indexPath.row].name else {
        return talaCell
    }
    
    className.text = classN
    className.adjustsFontSizeToFitWidth = true
    className.textAlignment = .Left
    dispatch_async(dispatch_get_main_queue(),{
        className.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(talaCell)
            make.left.equalTo(talaCell).offset(10)
            make.right.equalTo(talaCell).offset(-10)
        }
    })
    
    separatorBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.15)
    separatorBar.snp_makeConstraints { (make) -> Void in
        make.left.bottom.right.equalTo(talaCell)
        make.height.equalTo(0.5)
    }
    return talaCell
}