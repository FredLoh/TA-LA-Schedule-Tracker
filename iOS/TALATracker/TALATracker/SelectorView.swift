//
//  SelectorView.swift
//  TALATracker
//
//  Created by Frederik Lohner on 4/Dec/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
import UIKit

class ListenRecordSegmentedController: UIControl {
    private var labels = [UILabel]()
    var thumbView = UIView()
    
    var items: [String] = ["Classes","TA/LA's"] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = frame.height / 3.4
        //        layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).CGColor
        layer.borderColor = UIColor.clearColor().CGColor
        layer.borderWidth = 0.3
        backgroundColor = UIColor.whiteColor()
        
        setupLabels()
        
        insertSubview(thumbView, atIndex: 0)
        
    }
    
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
            
        }
        labels.removeAll(keepCapacity: true)
        for index in 1...items.count {
            let label = UILabel(frame: CGRectZero)
            label.text = items[index - 1]
            label.textAlignment = .Center
            label.textColor = UIColor(red:0.54, green:0.54, blue:0.54, alpha:1.0)
            if selectedIndex == index {
                label.font = activeFont
            } else {
                label.font = inactiveFont
            }
            self.addSubview(label)
            labels.append(label)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectedFrame = self.bounds
        let newWidth = CGRectGetWidth(selectedFrame) / CGFloat(items.count)
        selectedFrame.size.width = newWidth
        thumbView.frame = selectedFrame
        thumbView.backgroundColor = yellowColor
        //                thumbView.layer.cornerRadius = thumbView.frame.height / 3.4
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1 {
            
            let label = labels[index]
            
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRectMake(xPosition, 0, labelWidth, labelHeight)
            if selectedIndex == index {
                labels[index].textColor = UIColor.whiteColor()
                labels[index].font = activeFont
            } else {
                labels[index].textColor = UIColor(red:0.54, green:0.54, blue:0.54, alpha:1.0)
                labels[index].font = inactiveFont
            }
        }
    }
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        var calculatedIndex: Int?
        for(index, item) in EnumerateSequence(labels) {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
            if selectedIndex == 0 {
                sendAction("handleSingleTap:", to: nil, forEvent: nil)
            } else {
                sendAction("handleSingleTap:", to: nil, forEvent: nil)
            }
        }
        return false
    }
    
    func displayNewSelectedIndex() {
        let label = labels[selectedIndex]
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: {
            
            self.thumbView.frame = label.frame
            if self.selectedIndex == 0 {
                self.thumbView.backgroundColor = yellowColor
                self.labels[1].textColor = UIColor(red:0.54, green:0.54, blue:0.54, alpha:1.0)
                self.labels[1].font = inactiveFont
                self.labels[0].textColor = UIColor.whiteColor()
                self.labels[0].font = activeFont
                
            } else {
                self.thumbView.backgroundColor = redColor
                self.labels[0].textColor = UIColor(red:0.54, green:0.54, blue:0.54, alpha:1.0)
                self.labels[0].font = inactiveFont
                self.labels[1].textColor = UIColor.whiteColor()
                self.labels[1].font = activeFont
            }
            }, completion: nil)
        
    }
}