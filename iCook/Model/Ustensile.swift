//
//  Ingredient.swift
//  iCook
//
//  Created by Fabien on 31/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import Foundation

class Ustensile {
    var nom:String;
    var quantite:Int;
    
    
    public init(nom:String,  withQuantite quantite:Int) {
        self.nom = nom
        self.quantite = quantite
    }
}

