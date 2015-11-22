//
//  PhotoEditor.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//

import UIKit

class PhotoEditorViewController: ViewController {

    // The black/gray dot indicates that this object have an reference to the storyboard
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var blendModeBtnsContainer: UIScrollView!
    
    
    @IBOutlet weak var redSlider: ColorSlider!
    
    
    var blendModeSelected:CGBlendMode = CGBlendMode.Normal;
    var originalImage: UIImage = UIImage(named:"Samix")!
    var tintColor: UIColor = UIColor.whiteColor();
    var base64Str:String?
    
    typealias BlendModeType = [String: CGBlendMode]
    
    // This array contains every blend mode available in Photoshop
    // We put keywords "let" before because theses arrays will not mutate
    let blendModeList: [CGBlendMode] = [CGBlendMode.Normal, CGBlendMode.Multiply, CGBlendMode.Screen, CGBlendMode.Overlay, CGBlendMode.Darken, CGBlendMode.Lighten, CGBlendMode.ColorDodge, CGBlendMode.ColorBurn, CGBlendMode.SoftLight, CGBlendMode.HardLight, CGBlendMode.Difference, CGBlendMode.Exclusion, CGBlendMode.Hue, CGBlendMode.Saturation, CGBlendMode.Color, CGBlendMode.Luminosity]
    // This array contains every blend mode available in Photoshop litteraly
    let blendModeListNames:[String] = ["normal", "multiply",
        "screen", "overlay",
        "darken", "lighten",
        "color dodge", "color burn",
        "soft light", "hard light",
        "difference", "hue",
        "saturation", "color", "luminosity"];
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.channelName = .RED;
        
        let lastView:UIView = mainScrollView.subviews.last!;

        mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(lastView.frame));

        var blendModeDict = [String: CGBlendMode]()
        
        // We create an dictionary (associated array) of blend mode
        // key is blendmode name and value the blend mode
        for aBlendMode in zip(blendModeList, blendModeListNames) {
            let blendModeName:String = NSLocalizedString(aBlendMode.1 as String, comment: "comment");
            blendModeDict[blendModeName] = aBlendMode.0;
        }
        
        // We order keys by name alphabetically...
        let blendModeArray = blendModeDict.sort { $0.0 < $1.0 };
        
        let btnWidth:CGFloat = 100;
        
        // We enumerate
        for (index, item) in blendModeArray.enumerate() {
            let xPos:CGFloat = CGFloat(index * 20) + btnWidth * CGFloat(index);
            
            let aBlendBtn:BlendModeButton = BlendModeButton(frame: CGRectMake(xPos, 0, btnWidth, 50),
                blendMode: item.1);
            aBlendBtn.titleLabel?.adjustsFontSizeToFitWidth = true;
            aBlendBtn.backgroundColor = UIColor.redColor()
            aBlendBtn.setTitle(item.0 as String, forState: .Normal);
            aBlendBtn.addTarget(self, action: "changeBlendMode:", forControlEvents: .TouchUpInside);
            
            blendModeBtnsContainer.addSubview(aBlendBtn);
        }
        
        // We filter every member of class "BlendModeButton" in blendModeBtnsContainer
        // and we take the first element 
        let firstBtn = blendModeBtnsContainer.subviews.filter{$0 is BlendModeButton}[0] as? BlendModeButton;
        firstBtn!.selected = true;

        
        let lastBtn = blendModeBtnsContainer.subviews.filter{$0 is BlendModeButton}.last as! BlendModeButton;
        blendModeBtnsContainer.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame), CGRectGetHeight(lastBtn.frame));
        blendModeBtnsContainer.frame = CGRectMake(CGRectGetMinX(blendModeBtnsContainer.frame),
            CGRectGetMinY(blendModeBtnsContainer.frame),
            CGRectGetWidth(blendModeBtnsContainer.frame),
            CGRectGetHeight(lastBtn.frame));
    }
    
    // MARK: IBAction
    @IBAction func resetBlendMode(sender: BlendModeButton) {
        self.photoView.image = originalImage;
        
        BlendModeButton.resetButtons(sender);
    }
    
    @IBAction func changeBlendMode(sender: BlendModeButton) {
        blendModeSelected = sender.blendMode;
        applyBlendMode();
    }
    
    // User holds down the slider
    @IBAction func endEdit(sender: UISlider) {
        let redChannel:CGFloat = CGFloat(floor(sender.value * 256));
        
        let greenChannel:CGFloat = CGFloat(drand48());
        let blueChannel:CGFloat = CGFloat(drand48());
        let alphaChannel:CGFloat = 1.0;
        
        tintColor = UIColor(red: redChannel/255, green: greenChannel, blue: blueChannel, alpha: alphaChannel);
//        let color = CGColorCreateCopyWithAlpha(<#T##color: CGColor?##CGColor?#>, <#T##alpha: CGFloat##CGFloat#>)
        applyBlendMode()
    }
    
    // encode in base64 the image create by the user
    @IBAction func generateBase64Image(sender: UIButton) {
        let imageData = UIImagePNGRepresentation(self.photoView.image!)
        base64Str = imageData!.base64EncodedStringWithOptions([])
    }
    
    // Apply the blend mode
    func applyBlendMode() {
        let tintedImage = originalImage.tintWithColorAndBlendMode(tintColor, blendMode: blendModeSelected);
        self.photoView.image = tintedImage;
    }
    
    // This part manage every
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "passurl") {
            let navigationController: AnyObject = segue.destinationViewController
//            let destViewController = navigationController.topViewController as! GeneratedImageViewController;
//            
//            destViewController.base64ImageStr = base64Str;
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
