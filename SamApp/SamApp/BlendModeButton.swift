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
}