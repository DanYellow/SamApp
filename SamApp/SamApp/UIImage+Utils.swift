//
//  UIImage+Utils.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImage {
    /** 
    Tints an UIImage with a specific color.
    
    - Parameter color: color which will be apply on the UIImage. (Default white with 50 % alpha)
    
    - Returns: an UIImage tinted
    */
    func tintWithColor(color:UIColor = UIColor(white: 1.0, alpha: 0.5))->UIImage
    {
        // Make a rectangle the size of your image
        let rect = CGRectMake(0, 0, self.size.width, self.size.height);
        // Create a new bitmap context based on the current image's size and scale, that has opacity
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale);
        // Get a reference to the current context (which you just created)
        let c = UIGraphicsGetCurrentContext();
        // Draw your image into the context we created
        self.drawInRect(rect);
        // Set the fill color of the context
        CGContextSetFillColorWithColor(c, color.CGColor);
        // This sets the blend mode, which is not super helpful. Basically it uses the your fill color with the alpha of the image and vice versa. I'll include a link with more info.
        CGContextSetBlendMode(c, CGBlendMode.Multiply);
        // Now you apply the color and blend mode onto your context.
        CGContextFillRect(c, rect);
        // You grab the result of all this drawing from the context.
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        return newImage
    }
    
    /**
    Tints an UIImage with a specific color and a specific blend mode.
    
    - Parameter color: color which will be apply on the UIImage. (Default white with 50 % alpha)
    - Parameter blendMode: Blend mode to apply (Default Multiply - "Produit" in French)
    
    - Returns: an UIImage tinted with and blendMode apply
    */
    func tintWithColorAndBlendMode(color:UIColor = UIColor(white: 1.0, alpha: 0.5),
        blendMode:CGBlendMode = CGBlendMode.Multiply)->UIImage
    {
        let rect = CGRectMake(0, 0, self.size.width, self.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale);
        let c = UIGraphicsGetCurrentContext();
        self.drawInRect(rect);
        
        CGContextSetFillColorWithColor(c, color.CGColor);
        CGContextSetBlendMode(c, blendMode);
        
        CGContextFillRect(c, rect);
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        return newImage
    }
    
    
    func resizeImage(targetSize sizeImg: CGSize, isOpaque: Bool = true) -> UIImage {
        let rect = AVMakeRectWithAspectRatioInsideRect(self.size, CGRect(origin: CGPointZero, size: sizeImg));
        let size = rect.size;
        let scale:CGFloat = 0.0; // = UIScreen.mainScreen().scale
        
        UIGraphicsBeginImageContextWithOptions(size, isOpaque, scale);
        self.drawInRect(CGRect(origin: CGPointZero, size: size));
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return scaledImage;
    }
}