//
//  TADetailsView.swift
//  TALATracker
//
//  Created by Frederik Lohner on 4/Dec/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TADetailsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let picture = UIImageView()
    let name = UILabel()
    let classes = UITableView()
    var classID: String?
    var taName: String?
    
    
    func back() {
        self.performSegueWithIdentifier("back", sender: self)
    }
    
    override func viewDidLoad() {
        let topBar = generateTopBar(self.view)
        let backArrow = UIButton()
        backArrow.setImage(UIImage(named: "backArrow"), forState: UIControlState.Normal)
        backArrow.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        topBar.addSubview(backArrow)
        backArrow.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(30)
            make.left.equalTo(topBar).offset(10)
            make.centerY.equalTo(topBar)
        }

        picture.image = UIImage(named: "CU")
        name.text = "\(taName!)"
        name.font = taNameFont
        classes.delegate = self
        classes.dataSource = self
        classes.separatorStyle = .None
        self.view.addSubview(picture)
        self.view.addSubview(name)
        self.view.addSubview(classes)
        picture.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(200)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topBar.snp_bottom).offset(20)
        }
        name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(picture.snp_bottom).offset(5)
            make.centerX.equalTo(picture)
        }
        classes.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.top.equalTo(name.snp_bottom).offset(10)
            make.height.equalTo(100)
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let sesh = UILabel()
        cell.addSubview(sesh)
        sesh.text = sessionArray[indexPath.row].dateTime
        sesh.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(cell)
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "back") {
            let svc = segue.destinationViewController as! ClassDetailsView
            svc.classID = classID

        }
    }
}