//
//  ListFonts.swift
//  SamApp
//
//  Created by Jean-Louis Danielo on 30/11/2015.
//  Copyright © 2015 Jean-Louis Danielo. All rights reserved.
//

/**
    TODO for this page

    - Afficher dans l'ordre alphabétique le nom des polices
    - Changer le fond de la police utilisée ET changer la police
    - Afficher une vue au-dessus du clavier qui permet de changer la police du texte écrit
        • Indiquer la police utilisée
        • La propriété inputAccessoryView pourrait t'aider
*/


import UIKit

class ListFonts: UICollectionView {
    
    // It's just and identifier any name is correct
    let CELLIDENTIFIER = "ListItem";

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.delegate = self;
        self.dataSource = self;
        
        // This line allow us to create a reference to UICollectionView's UICollectionViewCell's xib
        // If We had not use xib but only a class (subclass of UICollectionViewCell) I had to use
        // self.registerClass(_my_Class_.self, forCellWithReuseIdentifier: CELLIDENTIFIER);
        self.registerNib(UINib(nibName: "ListFontItemXib", bundle: nil), forCellWithReuseIdentifier: CELLIDENTIFIER);        
        self.backgroundColor = UIColor.clearColor();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListFonts:UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UIFont.familyNames().count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:ListFontsItem = collectionView.dequeueReusableCellWithReuseIdentifier(CELLIDENTIFIER, forIndexPath: indexPath) as! ListFontsItem;
    
        cell.label.text = "hello";
        cell.backgroundColor = UIColor.lightGrayColor();
        
        return cell;
    }
}

extension ListFonts:UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
}