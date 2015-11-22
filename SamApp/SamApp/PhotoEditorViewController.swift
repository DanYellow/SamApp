//
//  PhotoEditor.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//



/**
    TODO for this page

    Afficher sur le rectangle en bas à gauche le couleur courante
    Déactiver un effet en appuyant sur un bouton déjà sélectionné (utiliser la fonction "changeBlendMode" déjà présente. Merci 😉
    Donner la possibilité de modifier chaque canal (actuellement seul le rouge est géré par le slider) (rouge, bleu, vert et pourquoi pas l'opacité)
        - Je veux que ces sliders aient leur barre vert pour le vert, bleu pour le bleu et gris (n'importe lequel) pour l'alpha
        - une partie du code est déjà présente dans la fonction "colorUpdated"
*/

import UIKit

class PhotoEditorViewController: ViewController {

    // The black/gray dot indicates that this object have an reference to the storyboard
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var blendModeBtnsContainer: UIScrollView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var redSlider: ColorSlider!
    
    
    var blendModeSelected:CGBlendMode = CGBlendMode.Normal;
    // The name of the image is related to the file Assets.xcassets
    // This filetype is and container of images. It's way more elegant than have every image in the file explorer
    private var originalImage: UIImage = UIImage(named:"Samix")!
    private var tintColor: UIColor = UIColor.whiteColor();
    var base64Str:String?
    
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
        let blendModesArray = blendModeDict.sort { $0.0 < $1.0 };
        
        let btnWidth:CGFloat = 100;
        
        // We enumerate through blendModesArray
        // place item represents the 
        for (index, item) in blendModesArray.enumerate() {
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
        // We set the frame of the container of blendmode button
        // x : 10 to be elegant
        // y : we get the y from storyboard placement
        // width : screen width - 20 (the view'x is 10)
        // height : height of blendmode button
        blendModeBtnsContainer.frame = CGRectMake(10,
            CGRectGetMinY(blendModeBtnsContainer.frame),
            CGRectGetWidth(self.view.frame) - 20,
            CGRectGetHeight(lastBtn.frame));
        print(blendModeBtnsContainer.frame);
    }
    
    // MARK: IBAction
    @IBAction func resetBlendMode(sender: UIButton) {
        self.photoView.image = originalImage;
        
//        BlendModeButton.resetButtons(sender);
    }
    
    @IBAction func changeBlendMode(sender: BlendModeButton) {
        blendModeSelected = sender.blendMode;
        applyBlendMode();
//        
//        UIView.animateWithDuration(0.2, animations: {
//            self.redSlider.setValue(Float(drand48()), animated: true);
//        });
        
    }
    
    // User holds down the slider
    @IBAction func colorUpdated(sender: ColorSlider) {
        let redChannel:CGFloat = CGFloat(floor(sender.value * 256));
        
        let greenChannel:CGFloat = CGFloat(drand48());
        let blueChannel:CGFloat = CGFloat(drand48());
        let alphaChannel:CGFloat = 1.0;
        
        
        tintColor = UIColor(red: redChannel/255, green: greenChannel, blue: blueChannel, alpha: alphaChannel);
        
        // Uncomment this code (cmd + /) to manage the objective : "Donner la possibilité de modifier chaque canal..."
//        // Retrieve each component of current color
//        let colorComponents = CGColorGetComponents(tintColor.CGColor);
//        // Retrieve alpha value of component (colorComponents[3] works too)
//        let alphaChannel = CGColorGetAlpha(tintColor.CGColor);
//        // Retrieve current slider value
//        let sliderValue = CGFloat(sender.value);
//        
//        switch (sender.channelName) {
//        case .RED:
//            tintColor = UIColor(red: sliderValue, green: colorComponents[1], blue: colorComponents[3], alpha: alphaChannel)
//            break;
//        case .GREEN:
//            tintColor = UIColor(red: colorComponents[0], green: sliderValue, blue: colorComponents[3], alpha: alphaChannel)
//            break;
//        case .BLUE:
//            tintColor = UIColor(red: colorComponents[0], green: colorComponents[1], blue: sliderValue, alpha: alphaChannel)
//            break;
//        case .ALPHA:
//            tintColor = UIColor(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[3], alpha: sliderValue)
//            break;
//            
//        default:
//            break;
//        }
        
        
        applyBlendMode()
    }
    
    // encode in base64 the image create by the user
    @IBAction func generateBase64Image() {
        let imageData = UIImagePNGRepresentation(self.photoView.image!)
        base64Str = imageData!.base64EncodedStringWithOptions([])
    }
    
    // Apply the blend mode
    func applyBlendMode() {
        let tintedImage = originalImage.tintWithColorAndBlendMode(tintColor, blendMode: blendModeSelected);
        self.photoView.image = tintedImage;
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "pushImage") {
            let navigationController: AnyObject = segue.destinationViewController
            let destViewController = navigationController.topViewController as! GeneratedImageViewController;
            generateBase64Image();
            destViewController.base64ImageStr = base64Str;
            // Because the pus his manage by storyboard we don't need to 
            // set a method to push only properties needed for next view are useful
        }
    }
    
    // Maybe one of the coolest feature of Storyboard
    // when you put a function with this signature "(segue:UIStoryboardSegue)"
    // Any component drag to 'exit' can back to this view it's very useful
    @IBAction func unwinded(segue:UIStoryboardSegue) {
        print(segue.sourceViewController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
