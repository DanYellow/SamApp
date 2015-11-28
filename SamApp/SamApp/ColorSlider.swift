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
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

}
