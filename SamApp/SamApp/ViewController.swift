//
//  ViewController.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//


/**
    @TODO

    - Choisir une photo depuis son album, c'est cool. Choisir la source, c'est mieux ! Je voudrais donc qu'il soit possible de choisir une photo depuis son album OU l'appareil photo. Note l'iPhone prend des photos très grande, il serait peut être préférable de réduire la taille de la photo avant de la travailler
*/




import UIKit
// Required if we want to know if user has autorized app to access his camera roll
import Photos

class ViewController: UIViewController {
    // The question mark indicates to the compilater : my UIImage can be undefined
    private var imageSelected:UIImage?;
    
    // We need only one UIImagePickerController so it's a global var
    private let photoPicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        photoPicker.delegate = self
        photoPicker.allowsEditing = false
        photoPicker.sourceType = .PhotoLibrary
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choosePhotoFromAlbum() {
        let status:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()

        switch (status) {
        case .Authorized:
            self.presentViewController(photoPicker, animated: true, completion: nil)
            break;
        default:
            break;
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "photoEditor" {
            let destViewController:PhotoEditorViewController = segue.destinationViewController as! PhotoEditorViewController
            if imageSelected != nil {
                destViewController.imageSelected = imageSelected!;
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageSelected = image.resizeImage(targetSize: CGSizeMake(600, 600));
        print(imageSelected?.size);
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
