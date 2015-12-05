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
import SwiftOverlays
import SSZipArchive

class ClassListView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let backView = UIView()
    let tableView = UITableView()
    let segmentedView = ListenRecordSegmentedController()
    var sideSwipeRecognizer: UISwipeGestureRecognizer?
    var classID: String?
    var taName: String?
    
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
    
    func handleSingleTap(sender: UIButton) {
        SwiftOverlays.showBlockingWaitOverlayWithText("Loading!")
        //THIS IS THE TALA VIEW
        if segmentedView.selectedIndex == 1 {
            getTAListPOST({ () -> () in
                self.tableView.reloadData()
                SwiftOverlays.removeAllBlockingOverlays()
            })
        } else {
            //This is the classes view
            print("2")
            sendFirstPOST() { () -> () in
                self.tableView.reloadData()
                SwiftOverlays.removeAllBlockingOverlays()
            }
        }
        
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
        if segmentedView.selectedIndex == 0 {
            return classesArray.count
        } else {
            return TAArray.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if segmentedView.selectedIndex == 0 {
            return generateInitialCell(&classesArray, tableView: tableView, indexPath: indexPath)
        } else {
            return generateTALACell(&TAArray, tableView: tableView, indexPath: indexPath)
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if segmentedView.selectedIndex == 0 {
            let input = classesArray[indexPath.row].className![5...8]
            classID = input
            sendClassPOST(input) { () -> () in
                dispatch_async(dispatch_get_main_queue(),{
                    self.performSegueWithIdentifier("classDetailsSegue", sender: self)
                })
            }
        } else {
            let name = TAArray[indexPath.row].name
            getClassListFromTA(name!, success: { () -> () in
                dispatch_async(dispatch_get_main_queue(),{
                    self.taName = name
                    self.performSegueWithIdentifier("taClassListSegue", sender: self)
                })
            })
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "classDetailsSegue") {
            let svc = segue.destinationViewController as! ClassDetailsView
            svc.classID = classID
        } else if segue.identifier == "taClassListSegue" {
            let svc = segue.destinationViewController as! ClassListForTA
            svc.taName = taName
        }
    }
}