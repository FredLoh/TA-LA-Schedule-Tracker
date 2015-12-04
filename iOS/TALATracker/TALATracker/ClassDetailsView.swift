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
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(backView)
        backView.addSubview(tableView)
        backView.backgroundColor = UIColor.whiteColor()
        backView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.bottom.equalTo(self.view)
        }
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(backView)
            make.top.equalTo(backView).offset(40)
        }
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
    
    
}