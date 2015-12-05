//
//  TopBar.swift
//  TALATracker
//
//  Created by Frederik Lohner on 4/Dec/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SpriteKit
func generateTopBar(superView: UIView) -> UIView {
    let topBar = UIView()
    let separatorBar = UIView()
    
    superView.addSubview(topBar)
    topBar.addSubview(separatorBar)
    separatorBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.15)
    topBar.snp_makeConstraints { (make) -> Void in
        make.left.right.equalTo(superView)
        make.top.equalTo(superView).offset(20)
        make.height.equalTo(40)
    }
    separatorBar.snp_makeConstraints { (make) -> Void in
        make.left.bottom.right.equalTo(topBar)
        make.height.equalTo(0.5)
    }
    return topBar
}

    class Walls: SKSpriteNode {
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            didLoad()
        }
        
        func didLoad() {
            let rectangle = SKShapeNode(rectOfSize: CGSize(width:390, height:200))
            rectangle.position = CGPointMake(frame.midX-10, frame.midY + 50)
            rectangle.strokeColor = SKColor.blackColor()
            rectangle.glowWidth = 1.0
            rectangle.physicsBody = SKPhysicsBody(edgeChainFromPath: rectangle.path!)
            rectangle.physicsBody?.dynamic = false
        }
    }