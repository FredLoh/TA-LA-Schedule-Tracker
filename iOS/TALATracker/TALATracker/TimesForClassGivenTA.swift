//
//  TimesForClassGivenTA.swift
//  TALATracker
//
//  Created by Frederik Lohner on 6/Dec/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit

class TimesForClassGivenTA: UIViewController {
    let backButton = UIButton()
    var taName: String?
    override func viewDidLoad() {
        let topBar = generateTopBar(self.view)
        topBar.addSubview(backButton)
        backButton.setBackgroundImage(UIImage(named: "backArrow"), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(topBar).offset(5)
            make.height.width.equalTo(30)
            make.centerY.equalTo(topBar)
        }
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