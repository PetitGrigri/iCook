//
//  Recette.swift
//  iCook
//
//  Created by Fabien on 07/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import Foundation
import UIKit

class Recette {
    var nom:String
    var description:String
    var image:UIImage
    var etapes:[Etape] = [Etape]()
    
    public init(nom:String, description:String, image:UIImage) {
        self.nom = nom
        self.description = description
        self.image = image
    }
}
