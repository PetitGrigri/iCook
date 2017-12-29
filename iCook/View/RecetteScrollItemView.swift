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

    @IBOutlet weak var desciptionRecette: UILabel!
    @IBOutlet fileprivate weak var titreRecette: UILabel!
    @IBOutlet fileprivate weak var imageRecette: UIImageView!
    
    var delegate:TouchProtocol?
    
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
        print("L'utilisateur souhaite cuisiner une \(self.recette?.nom)")
        
        if (delegate != nil) {
            delegate?.touch()
        }
    }
}


