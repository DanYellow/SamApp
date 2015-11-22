//
//  BlendModeButton.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//

import Foundation

import UIKit

class BlendModeButton: UIButton {
    /// CGBlendMode related to the button
    var blendMode:CGBlendMode;
    
    init(frame aRect:CGRect, blendMode aBlendMode:CGBlendMode) {
        
        /// This property must be declared before super (parent/mother) init
        self.blendMode = aBlendMode;
        
        super.init(frame: aRect);
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor.redColor().CGColor
        self.layer.borderWidth = 1.5;
        self.layer.masksToBounds = true;
        self.backgroundColor = UIColor.blueColor()
        self.tintColor = UIColor.whiteColor()
        self.titleLabel?.textAlignment = .Center;
        self.addTarget(self, action: "btnSelected:", forControlEvents: .TouchUpInside);
        self.setBackgroundImage(self.imageWithColor(.blackColor()), forState: .Selected);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Change the status of the current button selected
    func btnSelected(sender: BlendModeButton) {
        self.manageSelectedBtns(sender);
        self.selected = !self.selected;
    }
    
    /// Set to disable **every** button in the page
    func manageSelectedBtns(sender: BlendModeButton) {
        resetButtonsManager(sender);
    }
    
    static func resetButtons(sender: BlendModeButton) {
        sender.selected = false;
    }
    
    func resetButtonsManager(sender: BlendModeButton) {
        let blendModeButtons = self.superview?.subviews.filter( { $0 is BlendModeButton });
        
        if let btns = blendModeButtons {
            for btn in btns {
                if let blendModeBtn = btn as? BlendModeButton {
                    // If the current button is already selected we change
                    if blendModeBtn != sender {
                        blendModeBtn.selected = false;
                    }
                }
            }
        }
    }

}