//
//  UIView+Utils.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 28/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//

import UIKit

extension UIView {

    /**
        - returns : the view with the maxY __(view.origin.y + view.size.height)__
    */
    func bottomestUIView()->CGRect
    {
        // Contains the frames of all elements in mainScrollView
        let selfSubviewsFrames = (self.subviews as NSArray).valueForKeyPath("frame") as! NSArray;
        
        let maxYValues:[CGFloat] = selfSubviewsFrames.map({ rect -> CGFloat in
            let maxY = (rect.CGRectValue).maxY;
            return maxY;
        });
        
        let frames:[CGRect] = selfSubviewsFrames.map({ rect -> CGRect in
            let aRect = (rect.CGRectValue);
            return aRect;
        }).filter({
            let aRect = $0;
            return aRect.maxY == maxYValues.maxElement()!
        })

        return frames[0];
    }
    
    /**
    - returns : the view with the maxY __(view.origin.y + view.size.height)__
    */
    func topestUIView()->CGRect
    {
        // Contains the frames of all elements in mainScrollView
        let selfSubviewsFrames = (self.subviews as NSArray).valueForKeyPath("frame") as! NSArray;
        
        let minYValues:[CGFloat] = selfSubviewsFrames.map({ rect -> CGFloat in
            let minY = (rect.CGRectValue).minY;
            return minY;
        });
        
        let frames:[CGRect] = selfSubviewsFrames.map({ rect -> CGRect in
            let aRect = (rect.CGRectValue);
            return aRect;
        }).filter({
            let aRect = $0;
            return aRect.minY == minYValues.minElement()!
        })
        
        return frames[0];
    }

}
