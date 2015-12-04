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
    
    override func viewDidLoad() {
        picture.image = UIImage(named: "CU")
        name.text = "TALA NAME"
        name.font = taNameFont
        classes.delegate = self
        classes.dataSource = self
        self.view.addSubview(picture)
        self.view.addSubview(name)
        self.view.addSubview(classes)
        picture.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(200)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(50)
        }
        name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(picture.snp_bottom).offset(5)
            make.centerX.equalTo(picture)
        }
        classes.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.top.equalTo(name.snp_bottom).offset(10)
            make.height.equalTo(200)
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.separatorInset.left = 0
        cell.separatorInset.right = 0
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}