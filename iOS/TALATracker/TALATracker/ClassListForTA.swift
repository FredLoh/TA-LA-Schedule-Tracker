//
//  ClassListForTA.swift
//  TALATracker
//
//  Created by Frederik Lohner on 5/Dec/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ClassListForTA: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var taName: String?
    
    func back() {
        self.performSegueWithIdentifier("back", sender: self)
    }
    
    override func viewDidLoad() {
        addClass { () -> () in
            print("Success")
        }
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
        let title = UILabel()
        title.text = "Class List for \(taName!)"
        title.font = taNameFont
        title.adjustsFontSizeToFitWidth = true
        topBar.addSubview(title)
        title.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(topBar)
            make.left.equalTo(backArrow.snp_right).offset(5)
            make.right.equalTo(topBar).offset(-45)
        }
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(topBar.snp_bottom)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classesArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return generateInitialCell(&classesArray, tableView: tableView, indexPath: indexPath)
    }
    
}