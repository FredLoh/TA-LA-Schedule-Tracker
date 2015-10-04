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
    
    override func viewDidLoad() {
        BaseJSONGet { () -> () in
            print("SUCCESS")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let classCell: ClassListCell = tableView.dequeueReusableCellWithIdentifier("ClassListCell", forIndexPath: indexPath) as! ClassListCell
        
        classCell.className.text = "Test"
        classCell.classNumber.text = "3308"
        
        
        return classCell
    }
}