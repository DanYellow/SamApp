//
//  GeneratedImageViewController.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//

/**
    TODO for this page

    Sauvegarder l'image sans l'album photo
        - Utiliser la méthode "saveImageToAlbum" !
*/

import UIKit

class GeneratedImageViewController: UIViewController {

    @IBOutlet weak var generatedPhoto: UIImageView!
    
    
    // This variable is declared outside func
    // so I can access it everywhere in the code
    // and access it as a property if I instantiate the ViewController "GeneratedImageViewController"
    /// Base64-encoded data.
    var base64ImageStr:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We retrieve programatically the parent of the UIImageView containing the generated image
        // We are sure of the type of the parent so we put an exclamation mark (!)
        let generatedPhotoContainer = generatedPhoto.superview as! UIScrollView;
        generatedPhotoContainer.contentSize = CGSizeMake(CGRectGetWidth(generatedPhoto.frame), CGRectGetHeight(generatedPhoto.frame));
//        generatedPhotoContainer.frame.size.height = CGRectGetHeight(generatedPhoto.frame);
        generatedPhotoContainer.minimumZoomScale = 1;
        generatedPhotoContainer.maximumZoomScale = 5;
        generatedPhotoContainer.clipsToBounds = true;
        generatedPhotoContainer.backgroundColor = UIColor.redColor();
        generatedPhotoContainer.zoomScale = 1.0;
        
        // 😯- This things is impossible in Obj-C
        generatedPhoto.frame.origin.x = 0;
        generatedPhoto.frame.origin.y = 0;
        
        // We check if there is a value in property base64ImageStr
        // If there is one the property is automatically associated to the const base64Str
        if let base64Str = base64ImageStr
        {
            // We decode the based64 image encoded in the previous view...
            let decodedData = NSData(base64EncodedString: base64Str, options: NSDataBase64DecodingOptions(rawValue: 0))
            let decodedimage = UIImage(data: decodedData!)
            // and display it in the uiimageview
            generatedPhoto.image = decodedimage;
            
            generatedPhotoContainer.bounds = CGRectMake(CGFloat(0), CGFloat(0), CGFloat(CGImageGetWidth(generatedPhoto.image!.CGImage)), CGFloat(CGImageGetHeight(generatedPhoto.image!.CGImage)) )
        }
        
    }
    
    
    // MARK: IBACTION
    /**
    Save image to the user's photo album
    (Removes the oldest data point if the data source contains kMaxDataPoints objects.)
    */
    @IBAction func saveImageToAlbum() {
        UIImageWriteToSavedPhotosAlbum(generatedPhoto.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    @IBAction func dismissEvent(sender: AnyObject) {
        performSegueWithIdentifier("dismissModal", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - UIScrollViewDelegate
extension GeneratedImageViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.generatedPhoto;
    }
}
