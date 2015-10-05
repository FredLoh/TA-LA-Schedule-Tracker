//
//  ClassListView.swift
//  TALATracker
//
//  Created by Frederik Lohner on 4/Oct/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit

class ClassListView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        BaseJSONGet { () -> () in
            print("SUCCESS")
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
         let classCell: ClassListCell = tableView.dequeueReusableCellWithIdentifier("ClassListCell", forIndexPath: indexPath) as! ClassListCell
        
        classCell.className.text = TestArray[indexPath.row]["class"] as? String
        classCell.classNumber.text = TestArray[indexPath.row]["class-num"] as? String
        
        
        return classCell
    }
}