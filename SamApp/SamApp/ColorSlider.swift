//
//  ColorSlider.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//

import UIKit

enum ChannelName {
    case RED;
    case BLUE;
    case GREEN;
    case ALPHA;
}

class ColorSlider: UISlider {
    
    var channelName:ChannelName = ChannelName.RED;
    
    init(aRect:CGRect) {
        super.init(frame: aRect);
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
//        fatalError("init(coder:) has not been implemented")
    }

}
