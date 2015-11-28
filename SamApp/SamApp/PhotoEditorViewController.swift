//
//  PhotoEditor.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//



/**
    TODO for this page
    
    - Put the reverse color of colorIndicatorView's background for border color (layer.borderColor property). E.g. : If the background is black, then its border color have to be white (remember in Cocoa, UIColor component value is ranged between 0 and 1
    - set a **translated** title for editTextBtn
*/

import UIKit

class PhotoEditorViewController: ViewController {

    // The black/gray dot indicates that this object have an reference to the storyboard
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var blendModeBtnsContainer: UIScrollView!
    @IBOutlet weak var resetButton: UIButton!

    
    // Management of slider
    @IBOutlet weak var redSlider: ColorSlider!
    @IBOutlet weak var greenSlider: ColorSlider!
    @IBOutlet weak var blueSlider: ColorSlider!
    
    // This view is an return of the color selected
    @IBOutlet weak var colorIndicatorView: UIView!
    
    
    var blendModeSelected:CGBlendMode = CGBlendMode.Normal;
    // The name of the image is related to the file Assets.xcassets
    // This filetype is and container of images. It's way more elegant than have every image in the file explorer
    private var originalImage: UIImage = UIImage(named:"Samix")!
    private var tintColor: UIColor = UIColor();
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
        self.view.backgroundColor = UIColor.whiteColor();
        
        // We associate to each slider which color composant it will change
        redSlider.channelName = .RED;
        greenSlider.channelName = .GREEN;
        blueSlider.channelName = .BLUE;
        
        blueSlider.translatesAutoresizingMaskIntoConstraints = false;
        

        
        let alphaSlider:ColorSlider = ColorSlider(frame: CGRectZero);
        alphaSlider.channelName = .ALPHA;
        // This line is very important it prevents xcode to do silly thing by adding unwanted constraints and worse 
        // crash the app for too many constraints. Oh the irony...
        alphaSlider.translatesAutoresizingMaskIntoConstraints = false;
        // addTarget is an method to add an event to object eligible like UIButton, UIGestureRecognizer or, for this case, a custom UISlider
        // action argument indicate which method have to be called when the "forControlEvents" is done
        // Note the ":" (colon) at the end of "colorUpdated", we have to put them because the "colorUpdated" method takes a param
        alphaSlider.addTarget(self, action: "colorUpdated:", forControlEvents: .TouchUpInside);
        // UIControlEvents.TouchUpOutside === .TouchUpOutside
        // It's just an shortned version
        alphaSlider.addTarget(self, action: "colorUpdated:", forControlEvents: UIControlEvents.TouchUpOutside);
        alphaSlider.maximumTrackTintColor = UIColor.lightGrayColor();
        alphaSlider.minimumTrackTintColor = UIColor.lightGrayColor();
        alphaSlider.value = 0.5;
        self.view.addSubview(alphaSlider);
        
        // We init the tint color with slider values
        tintColor = UIColor(red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: CGFloat(alphaSlider.value));
        
        // Except for unwind segue
        // What Storyboard can do
        // code can do it too !
        // Let's add an constraint to alphaSlider
        
        // NSLayoutConstraint is a little bit complex at the first sight 
        // so let's explain this
        
        // self.view.addConstraint
        // The method "addConstraint" is called by the container view, it's very important ! It takes an NSLayoutConstraint object as param
        // arg 1 - item : it's the item which recieved the constraint
        // arg 2 - attribute : the name of the property which will be modified by the constraint (cmd + click on "NSLayoutAttribute.Width" to see the list)
        // arg 3 - relatedBy :
        // arg 4 - toItem : the name of the reference view (it can be the view which called the method addConstraint)
        // arg 5 - attribute : the name of the property which will be use as reference
        // arg 6 - multiplier : multiplier if you want to modify the relation
        // arg 7 - constant : add an const if you want to modify the relation
        
        // We want the Width of blueSlider for alphaSlider
        self.view.addConstraint(
            NSLayoutConstraint(
                item: alphaSlider,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: blueSlider,
                attribute: .Width,
                multiplier: 1,
                constant: 0
            )
        );
        
        // We want the Height of blueSlider for alphaSlider
        self.view.addConstraint(
            NSLayoutConstraint(
                item: alphaSlider,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: blueSlider,
                attribute: .Height,
                multiplier: 1,
                constant: 0
            )
        );
        
        // It center alphaSlider in its superview
        self.view.addConstraint(
            NSLayoutConstraint(
                item: alphaSlider,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: alphaSlider.superview,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0
            )
        );
        
        // We want to add 50px to blueSlider top position
        self.view.addConstraint(
            NSLayoutConstraint(
                item: alphaSlider,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: blueSlider,
                attribute: .Bottom,
                multiplier: 1,
                constant: 15
            )
        );
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: blendModeBtnsContainer,
                attribute: .Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: alphaSlider,
                attribute: .Bottom,
                multiplier: 1,
                constant: 30
            )
        );
        
        
        // editTextBtn
        let editTextBtn:UIButton = UIButton(type: .System);
        editTextBtn.setTitle("please change my text and I want to be translated", forState: .Normal);
        // The text is too long so we create a line break
        editTextBtn.titleLabel?.lineBreakMode = .ByWordWrapping;
        editTextBtn.addTarget(self, action: "showTextEditor", forControlEvents: .TouchUpInside);
        mainScrollView.addSubview(editTextBtn);
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false;
        editTextBtn.translatesAutoresizingMaskIntoConstraints = false;
        mainScrollView.addConstraint(
            NSLayoutConstraint(
                item: editTextBtn,
                attribute: .Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: resetButton,
                attribute: .Bottom,
                multiplier: 1,
                constant: 30
            )
        );

        mainScrollView.addConstraint(
            NSLayoutConstraint(
                item: editTextBtn,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: blueSlider,
                attribute: .Height,
                multiplier: 1.5,
                constant: 0
            )
        );

        mainScrollView.addConstraint(
            NSLayoutConstraint(
                item: editTextBtn,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: editTextBtn.superview,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0
            )
        );
        
        // NSLayout constraint can also be created with a "visual format"
        let views:[String:UIButton] = ["button": editTextBtn];
        mainScrollView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("[button(200.0)]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: views
            )
        )
        
        // this property force mainScrollView to update its layout in other words "notify it" to know its new guests
        mainScrollView.layoutIfNeeded()
        

        var blendModeDict = [String: CGBlendMode]()
        // We create an dictionary (associated array) of blend mode
        // key is blendmode name and value the blend mode
        for aBlendMode in zip(blendModeList, blendModeListNames) {
            let blendModeName:String = NSLocalizedString(aBlendMode.1 as String, comment: "comment");
            blendModeDict[blendModeName] = aBlendMode.0;
        }
        
        // We order keys by name alphabetically
        let blendModesArray = blendModeDict.sort { $0.0 < $1.0 };

        let btnWidth:CGFloat = 100;
        // We enumerate through blendModesArray
        for (index, item) in blendModesArray.enumerate() {
            let xPos:CGFloat = CGFloat(index * 20) + btnWidth * CGFloat(index);
            
            let aBlendBtn:BlendModeButton = BlendModeButton(frame: CGRectMake(xPos, 0, btnWidth, 50),
                blendMode: item.1);
            // This line indicate that this ViewController manage the delegate method of the objects BlendModeButton
            aBlendBtn.delegate = self;
            aBlendBtn.titleLabel?.adjustsFontSizeToFitWidth = true;
            aBlendBtn.backgroundColor = UIColor.redColor()
            aBlendBtn.setTitle(item.0 as String, forState: .Normal);
            
            /// We remove this line because thanks to delegate
            /// the behaviour of "TouchUpInside" of BlendButtonMode manage the binding of events. The logic in "changeBlendMode" method is now in "btnSelected" method
//            aBlendBtn.addTarget(self, action: "changeBlendMode:", forControlEvents: .TouchUpInside);
            
            blendModeBtnsContainer.addSubview(aBlendBtn);
        }
        
        // We filter every member of class "BlendModeButton" in blendModeBtnsContainer
        // and we take the first element 
        let firstBtn = blendModeBtnsContainer.subviews.filter{$0 is BlendModeButton}[0] as? BlendModeButton;
        // We check if the first button exists
        if let firstBlendModeBtn = firstBtn {
            firstBlendModeBtn.selected = true;
            blendModeSelected = firstBlendModeBtn.blendMode
        }
        
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
        
        mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                                mainScrollView.bottomestUIView().maxY + CGRectGetHeight((self.navigationController?.navigationBar.frame)!));

        let photoViewTextlayer = CATextLayer()
        photoViewTextlayer.alignmentMode = kCAAlignmentJustified;
        photoViewTextlayer.string = "hello";
        photoViewTextlayer.wrapped = true;
        photoViewTextlayer.zPosition = 0;
        photoViewTextlayer.contentsScale = UIScreen.mainScreen().scale;
        photoViewTextlayer.frame = CGRectMake(27, 75, 267, 320);
        photoViewTextlayer.font = UIFont(name: "Helvetica", size: 10.0);
        self.photoView.layer.addSublayer(photoViewTextlayer);
    }
    
    // MARK: IBAction
    @IBAction func resetBlendMode(sender: BlendModeButton) {
        self.photoView.image = originalImage;
        
        BlendModeButton.resetButtons(sender);
    }

    
    @IBAction func colorUpdated(sender: ColorSlider) {
        // Retrieve each component of current color
        // Like this we can change only one component of the color
        let colorComponents = CGColorGetComponents(tintColor.CGColor);
        // Retrieve alpha value of component (colorComponents[3] works too)
        let alphaChannel = CGColorGetAlpha(tintColor.CGColor);
        // Retrieve current slider value
        let sliderValue = CGFloat(sender.value);
        
        switch (sender.channelName) {
        case .RED:
            tintColor = UIColor(red: sliderValue, green: colorComponents[1], blue: colorComponents[2], alpha: alphaChannel)
            break;
        case .GREEN:
            tintColor = UIColor(red: colorComponents[0], green: sliderValue, blue: colorComponents[2], alpha: alphaChannel)
            break;
        case .BLUE:
            tintColor = UIColor(red: colorComponents[0], green: colorComponents[1], blue: sliderValue, alpha: alphaChannel)
            break;
        case .ALPHA:
            tintColor = UIColor(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2], alpha: sliderValue)
            break;
        }
        
        let colorComponentsAfterUpdate = CGColorGetComponents(tintColor.CGColor);
        
        colorIndicatorView.backgroundColor = UIColor(red: colorComponentsAfterUpdate[0], green: colorComponentsAfterUpdate[1], blue: colorComponentsAfterUpdate[2], alpha: 1.0);
        
        applyBlendMode()
    }
    
    // encode in base64 the image create by the user
    @IBAction func generateBase64Image() {
        // We create a context (canvas) to contain our image
        // We can also use the method "UIGraphicsBeginImageContext" but we use some
        UIGraphicsBeginImageContextWithOptions(self.photoView.frame.size, true, UIScreen.mainScreen().scale)
        self.photoView.layer.renderInContext(UIGraphicsGetCurrentContext()!);

        let imageData = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext())
        base64Str = imageData!.base64EncodedStringWithOptions([])
        
        UIGraphicsGetCurrentContext();
    }
    
    // Apply the blend mode
    func applyBlendMode() {
        let tintedImage = originalImage.tintWithColorAndBlendMode(tintColor, blendMode: blendModeSelected);
        self.photoView.image = tintedImage;
    }
    
    
    func showTextEditor() {
        // We display the view controller by its id set in the storyboard
        // Select the NavigationController next to addTextViewController
        let addTextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Hello");
        
        self.presentViewController(addTextViewController!, animated: true, completion: nil);
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation <- Apple's engineers said that and they right
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

extension PhotoEditorViewController: BlendModeButtonDelegate {
    func btnSelected(sender: BlendModeButton) {
        if !sender.selected {
            // an @IBAction called programatically.
            // Yep it's possible but not the inverse
            resetBlendMode(sender);
        } else {
            blendModeSelected = sender.blendMode;
            applyBlendMode();
        }
    }
}
