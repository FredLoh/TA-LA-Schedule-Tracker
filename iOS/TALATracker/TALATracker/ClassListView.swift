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
    let segmentedView = ListenRecordSegmentedController()
    var sideSwipeRecognizer: UISwipeGestureRecognizer?
    var classID: String?
    
    func swipeLeft(recognizer : UISwipeGestureRecognizer) {
        if self.segmentedView.selectedIndex == 0 {
            self.segmentedView.selectedIndex = 1
            self.sideSwipeRecognizer?.direction = .Right
            
        } else {
            self.segmentedView.selectedIndex = 0
            self.sideSwipeRecognizer?.direction = .Left
        }
        self.segmentedView.displayNewSelectedIndex()
        segmentedView.sendAction("handleSingleTap:", to: nil, forEvent: nil)
    }

    
    override func viewDidLoad() {
        self.view.addSubview(backView)
//        let topBar = generateTopBar(backView)
        sideSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        sideSwipeRecognizer!.direction = .Left
        self.view.addGestureRecognizer(sideSwipeRecognizer!)
        backView.addSubview(segmentedView)
        segmentedView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(backView)
            make.top.equalTo(backView).offset(20)
            make.height.equalTo(50)
        }

        backView.backgroundColor = UIColor.whiteColor()
        backView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.bottom.equalTo(self.view)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.scrollEnabled = false
        backView.addSubview(tableView)
        dispatch_async(dispatch_get_main_queue(),{
            self.tableView.snp_makeConstraints { (make) -> Void in
                make.bottom.left.right.equalTo(self.backView)
                make.top.equalTo(self.segmentedView.snp_bottom)
            }
        })
        
        sendFirstPOST() { () -> () in
            self.tableView.reloadData()
        }
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        let classListTitle = UILabel()
        classListTitle.text = "Class List"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classesArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return generateInitialCell(&classesArray, tableView: tableView, indexPath: indexPath)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let input = classesArray[indexPath.row].className![5...8]
        classID = input
        sendClassPOST(input) { () -> () in
            dispatch_async(dispatch_get_main_queue(),{
                self.performSegueWithIdentifier("classDetailsSegue", sender: self)
            })
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "classDetailsSegue") {
            let svc = segue.destinationViewController as! ClassDetailsView
            svc.classID = classID
        }
    }
}