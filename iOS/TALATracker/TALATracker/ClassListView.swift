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
    let tableView = UITableView()

    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(80)
        }
        BaseJSONGet { () -> () in
            self.tableView.reloadData()
        }
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         return generateInitialCell(tableView, indexPath: indexPath)
    }
}