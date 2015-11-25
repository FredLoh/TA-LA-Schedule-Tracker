//
//  ClassListView.swift
//  TALATracker
//
//  Created by Frederik Lohner on 4/Oct/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ClassListView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let backView = UIView()
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        self.view.addSubview(backView)
        backView.backgroundColor = UIColor.whiteColor()
        backView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.bottom.equalTo(self.view)
        }
        tableView.delegate = self
        tableView.dataSource = self
        backView.addSubview(tableView)
        dispatch_async(dispatch_get_main_queue(),{
            self.tableView.snp_makeConstraints { (make) -> Void in
                make.bottom.left.right.equalTo(self.backView)
                make.top.equalTo(self.backView).offset(80)
            }
        })
        
        sendFirstPOST() { () -> () in
            self.tableView.reloadData()
        }
        
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return generateInitialCell(&infoArray, tableView: tableView, indexPath: indexPath)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let input = infoArray[indexPath.row].className![5...8]
        sendClassPOST(input)
    }
}