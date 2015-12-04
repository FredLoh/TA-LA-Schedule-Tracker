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

class ClassDetailsView: UIViewController {
    let backView = UIView()
    
    override func viewDidLoad() {
        self.view.addSubview(backView)
        backView.backgroundColor = UIColor.whiteColor()
        backView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.bottom.equalTo(self.view)
        }
    }
    
        
}