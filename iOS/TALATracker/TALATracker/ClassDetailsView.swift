//
//  ClassDetailsView.swift
//  TALATracker
//
//  Created by Frederik Lohner on 1/Dec/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ClassDetailsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let backView = UIView()
    let tableView = UITableView()
    var classID: String?
    var taName: String?
    
    func back() {
        self.performSegueWithIdentifier("back", sender: self)
    }
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(backView)
        backView.addSubview(tableView)
        backView.backgroundColor = UIColor.whiteColor()
        backView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.bottom.equalTo(self.view)
        }
        let topBar = generateTopBar(backView)
        let backArrow = UIButton()
        backArrow.setImage(UIImage(named: "backArrow"), forState: UIControlState.Normal)
        backArrow.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        topBar.addSubview(backArrow)
        backArrow.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(30)
            make.left.equalTo(topBar).offset(10)
            make.centerY.equalTo(topBar)
        }
        let title = UILabel()
        title.text = "TA / LA List"
        title.font = taNameFont
        topBar.addSubview(title)
        title.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(topBar)
        }
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(backView)
            make.top.equalTo(topBar.snp_bottom)
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
        print(TAArray)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TAArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let name = UILabel()
        name.text = TAArray[indexPath.row].name
        cell.addSubview(name)
        name.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(cell)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let name = TAArray[indexPath.row].name {
            sendSessionsPOST(classID!, taName: name) { () -> () in
                self.taName = name
                self.performSegueWithIdentifier("TADetailSegue", sender: self)
            }
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "TADetailSegue") {
            let svc = segue.destinationViewController as! TADetailsView
            svc.classID = classID
            svc.taName = taName
        }
    }
    
}