//
//  Ingredient.swift
//  iCook
//
//  Created by Fabien on 31/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import Foundation

class Ingredient {
    var nom:String;
    var quantite:Int;
    var unite:String;
    
    
    public init(nom:String,  withQuantite quantite:Int, withUnite unite:String) {
        self.nom = nom
        self.unite = unite
        self.quantite = quantite
    }
    
    
}
