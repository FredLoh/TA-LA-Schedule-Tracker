//
//  TimesForClassGivenTA.swift
//  TALATracker
//
//  Created by Frederik Lohner on 6/Dec/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit

class TimesForClassGivenTA: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let backButton = UIButton()
    var taName: String?
    let tableView = UITableView()
    
    override func viewDidLoad() {
        let topBar = generateTopBar(self.view)
        topBar.addSubview(backButton)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        backButton.setBackgroundImage(UIImage(named: "backArrow"), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(topBar).offset(5)
            make.height.width.equalTo(30)
            make.centerY.equalTo(topBar)
        }
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(topBar.snp_bottom)
        }
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorStyle = .None
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let time = UILabel()
        let sep = UIView()
        sep.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.15)
        time.text = sessionArray[indexPath.row].dateTime
        cell.addSubview(time)
        cell.addSubview(sep)
        time.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(cell).offset(5)
            make.right.equalTo(cell).offset(-5)
            make.centerY.equalTo(cell)
        }
        sep.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(cell)
            make.height.equalTo(0.5)
        }
        return cell
    }
    func back() {
        self.performSegueWithIdentifier("back", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "back") {
            let svc = segue.destinationViewController as! ClassListForTA
            svc.taName = taName
        }
    }
}