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
*/

import UIKit

class AddTextViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        // Do any additional setup after loading the view.
        
        let closeButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "closeModal:");

        self.navigationItem.leftBarButtonItem = closeButton;

    }
    
    func closeModal(segue: UIStoryboard) ->() {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
