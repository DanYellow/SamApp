//
//  AddTextViewController.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 27/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//

/**
    TODO for this page

    - Créer un délégué quimet à jour le texte de l'image sélectionnée
    - Afficher une vue au-dessus du clavier qui permet de changer la police du texte écrit
        • Indiquer la police utilisée
        • La propriété inputAccessoryView pourrait t'aider
*/

import UIKit

class AddTextViewController: UIViewController {
    
    @IBOutlet weak var photoTextField: UITextField!
    
    var inputText:String? = nil;
    var delegate: AddTextViewDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        // Do any additional setup after loading the view.
        
        let closeButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "closeModal:");

        self.navigationItem.leftBarButtonItem = closeButton;
        
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        // This property define the size of each cell of 
        flowLayout.itemSize = CGSizeMake(150, 44);
        flowLayout.scrollDirection = .Horizontal;
        let listFonts:ListFonts = ListFonts(frame: CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), 44), collectionViewLayout: flowLayout);
        
        photoTextField.inputAccessoryView = listFonts;
        photoTextField.autocorrectionType = UITextAutocorrectionType.No;
        
        // This View controller is now the delegate manager of photoTextField's delegates methods
        photoTextField.delegate = self;
        if let foo = inputText {
            photoTextField.text = foo;
        }
    }
    
    func closeModal(segue: UIStoryboard) ->() {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddTextViewController:UITextFieldDelegate {

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        delegate?.textEdited(textField: textField);
        
        return true;
    }
}

/// Called when button is selected
protocol AddTextViewDelegate {
    func textEdited(textField textField:UITextField);
}