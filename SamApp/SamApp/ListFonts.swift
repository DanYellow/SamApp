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
    - Afficher le nom de la police dans chacune des cellules ET afficher la nom de la cellule dans son nom
    - Afficher une vue au-dessus du clavier qui permet de changer la police du texte écrit
        • Indiquer la police utilisée
*/


import UIKit

class ListFonts: UICollectionView {
    
    // It's just and identifier any name is correct
    let CELLIDENTIFIER = "ListItem";
    // Contains every fonts available in iOS
    var fontsList:[String] = UIFont.familyNames();

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
        return fontsList.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:ListFontsItem = collectionView.dequeueReusableCellWithReuseIdentifier(CELLIDENTIFIER, forIndexPath: indexPath) as! ListFontsItem;

        cell.label.text = "Pikachu";
        cell.label.textAlignment = .Center;
        cell.backgroundColor = UIColor.lightGrayColor();
        return cell;
    }
}

extension ListFonts:UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let _ = collectionView.cellForItemAtIndexPath(indexPath) as? ListFontsItem {
            // Your code goes here
        }
    }
    
}

extension ListFonts:UICollectionViewDelegateFlowLayout {
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        let uselessLabel = UILabel(frame: CGRectZero);
//        uselessLabel.text = fontsList[indexPath.row];
//        
//        return CGSizeMake(uselessLabel.sizeThatFits(CGSizeMake(120, CGFloat.max)).width + 40, 44.0);
//    }
}