//
//  RecetteScrollViewController.swift
//  iCook
//
//  Created by Fabien on 06/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import Foundation
import UIKit

class RecetteScrollItemView: UIView {

    @IBOutlet weak var desciptionRecette: UITextView!
    @IBOutlet weak var titreRecette: UILabel!
    @IBOutlet weak var imageRecette: UIImageView!
    
    var recette:Recette? {
        didSet {
            reloadUI()
        }
    }
    
    func reloadUI() {
        print("load New Recette")
        
        //si on a pas de recette retour
        guard let maRecette = self.recette else {
            return
        }
        
        //modification de l'affichage de l'interface
        desciptionRecette.text = maRecette.description
        titreRecette.text = maRecette.nom
        imageRecette.image = maRecette.image
    }
    
    @IBAction func touchCuisiner(_ sender: Any) {
        print("touch Cuisiner")
        print("L'utilisateur a envie de cuisiner une \(self.recette?.nom)")
    }
}

