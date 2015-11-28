//
//  ViewController.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 22/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//


/**
    @TODO

    Donner la possibilité de récupérer une image depuis sa galerie photo 
        - ❗️Penser à l'imageview suivante
    Le plus :
        - Afficher un message d'erreur si on essaye de passer à la vue suivante sans avoir sélectionné une photo (utiliser UIAlertController)
*/




import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func foo(segue:UIStoryboardSegue) {
        print("trutrtr");
    }
}

