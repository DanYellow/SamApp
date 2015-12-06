//
//  ViewController.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//


/**
    @TODO

    - Je voudrais afficher la photo qui va être éditer. Pla
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choosePhotoSource() {
        let alertController = UIAlertController(title: nil, message: "Please choose an source", preferredStyle: .ActionSheet);
        alertController.modalPresentationStyle = .Popover
        
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Cancel) { action in
            
        }
        alertController.addAction(cancel);
        
        let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .Default) { action in
            self.choosePhotoFromCamera()
        }
        alertController.addAction(camera);
        
        let album = UIAlertAction(title: NSLocalizedString("Album", comment: ""), style: .Default) { action in
            self.choosePhotoFromAlbum()
        }
        alertController.addAction(album);
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func choosePhotoFromAlbum() {
        let status:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()

        // We check the photolibrary autorization
        switch (status) {
        case .Authorized:
            photoPicker.sourceType = .PhotoLibrary
            self.presentViewController(photoPicker, animated: true, completion: nil)
            break;
        default:
            break;
        }
    }
    
    func choosePhotoFromCamera() {
        // We check the photolibrary autorization
        if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) ==  AVAuthorizationStatus.Authorized {
            photoPicker.sourceType = .Camera
            self.presentViewController(photoPicker, animated: true, completion: nil)
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
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
