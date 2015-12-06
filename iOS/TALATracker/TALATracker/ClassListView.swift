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
    let addButton = UIButton()
    
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
                self.addButton.hidden = false
                SwiftOverlays.removeAllBlockingOverlays()
            })
        } else {
            //This is the classes view
            print("2")
            sendFirstPOST() { () -> () in
                self.tableView.reloadData()
                self.addButton.hidden = true
                SwiftOverlays.removeAllBlockingOverlays()
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        self.view.addSubview(backView)
        backView.addSubview(addButton)
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
        
        addButton.setBackgroundImage(UIImage(named: "add"), forState: UIControlState.Normal)
        addButton.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Highlighted)
        addButton.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(backView).offset(-5)
            make.height.width.equalTo(75)
        }
        addButton.addTarget(self, action: "addTA", forControlEvents: UIControlEvents.TouchUpInside)
        addButton.hidden = true
        backView.bringSubviewToFront(addButton)
    }
    
    func addTA() {
        let alert = UIAlertController(title: "Add TA/LA", message: "Please make sure to fill out all fields correctly!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter name:"
        })
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter class name:"
        })
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter days (M,T,W,Th,F):"
        })
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter times (ex: 11:00 AM - 1:00 PM):"
        })
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter location:"
        })
        let sendAction = UIAlertAction(title: "Send", style: .Default) { (action) in
            var didFillFields = true
            for(var i=0;i<alert.textFields?.count;i++) {
                if alert.textFields![i].text == "" {
                    didFillFields = false
                }
            }
            if didFillFields == true {
                guard let name = alert.textFields?[0].text,
                let className = alert.textFields?[1].text,
                let days = alert.textFields?[2].text,
                let times = alert.textFields?[3].text,
                    let location = alert.textFields?[4].text else {
                        return
                }
                addClass(name, className: className, days: days, times: times, location: location, success: { () -> () in
                    print("Class added succesfully")
                })
            }
        }
        alert.addAction(sendAction)
        self.presentViewController(alert, animated: true, completion: nil)
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